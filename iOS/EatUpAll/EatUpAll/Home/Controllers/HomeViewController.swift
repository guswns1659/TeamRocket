//
//  HomeViewController.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/13.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit
import Kingfisher

final class HomeViewController: UIViewController {

    @IBOutlet weak var tutorialView: UIView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var personalTotalView: UIView!
    @IBOutlet weak var personalTotalSavings: UILabel!
    @IBOutlet weak var todayWholePlates: UILabel!
    @IBOutlet weak var todayWholeSavings: UILabel!
    @IBOutlet weak var todayMyPlates: UILabel!
    @IBOutlet weak var todayMySavings: UILabel!
    @IBOutlet weak var todayWholeView: UIView!
    @IBOutlet weak var todayMyView: UIView!
    @IBOutlet weak var emptyPlateCollectionView: UICollectionView!
    @IBOutlet weak var findSurroundingRestaurantView: UIView!
    @IBOutlet weak var donationProjectCollectionView: ClosingDonationProjectCollectionView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    private var wholeTutorialView: WholeTutorialView!
    private var personalTotalSavingUseCase: PersonalTotalSavingUseCase!
    private var todayRecordUseCase: TodayRecordUseCase!
    private var challengeEmptyPlateUseCase: ChallengeEmptyPlateUseCase!
    private var emptyPlateInfo: ChallengeEmptyPlateContainer!
    private var donationProjectDataSource: DonationProjectCollectionViewDataSource<ClosingDonationProjectCell>!
    private var donationProjectDelegate: ClosingDonationProjectCollectionViewDelegate!
    private var donationUseCase: DonationUseCase!

    override func viewDidLoad() {
        indicator.startAnimating()
        configure()
        fetchDatas()
    }

    @objc func presentClosingDetailCell(_ notification: Notification) {
        let donationDetailViewController = DonationDetailViewController.loadFromNib()
        donationDetailViewController.modalPresentationStyle = .fullScreen

        guard let indexPath = notification.userInfo?["indexPath"] as? IndexPath else { return }
        donationProjectDataSource.referDonationProject(at: indexPath) { donationProject in
            self.present(donationDetailViewController, animated: true) {
                donationDetailViewController.fetchDonationDetailData(id: donationProject.id)
            }
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .selectionClosingDonationCell, object: nil)
    }

    @objc private func showTutorial(_ gesture: UIGestureRecognizer) {
        wholeTutorialView.isHidden = false
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emptyPlateInfo.data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EmptyPlateCollectionViewCell.self), for: indexPath) as! EmptyPlateCollectionViewCell
        let url = URL(string: emptyPlateInfo.data[indexPath.row].image)
        KingfisherManager.shared.retrieveImage(with: url!, options: nil, progressBlock: nil, downloadTaskUpdated: nil) { (result) in
            switch result {
            case .success(let value):
                cell.configureImage(value.image)
            case .failure(let error):
                print(error)
            }
        }
        return cell
    }
}

// MARK:- Fetch Datas

extension HomeViewController {
    private func fetchDatas() {
        fetchPersonalTotalSaving()
        fetchTodayRecords()
        fetchChallengeEmptyPlate()
        fetchDonationProjects()
    }

    private func fetchDonationProjects() {
        let request = DonationClosingProjectRequest().asURLRequest()
        donationUseCase.getResources(
            request: request,
            dataType: DonationProjectContainer.self) { (result) in
                switch result {
                case .success(let container):
                    self.donationProjectDataSource.updateDonationProjects(container.data)
                    self.indicator.stopAnimating()
                    self.indicator.hidesWhenStopped = true
                case .failure(_):
                    break
                }
        }
    }

    private func fetchPersonalTotalSaving() {
        let request = PersonalTotalSavingRequest().asURLRequest()
        personalTotalSavingUseCase.getResources(request: request, dataType: PersonalTotalSaving.self) { result in
            switch result {
            case .success(let data):
                self.userName.text = "\(data.accountName)"
                self.personalTotalSavings.text = String(format: "%.2f", arguments: [data.totalSaving])
            case .failure(let error):
                print(error)
            }
        }
    }

    private func fetchTodayRecords() {
        let request = TodayRecordRequest().asURLRequest()
        todayRecordUseCase.getResources(request: request, dataType: TodayRecord.self) { result in
            switch result {
            case .success(let record):
                self.todayWholePlates.text = "\(record.todayTotalPlates)"
                self.todayWholeSavings.text = String(format: "%.2f", arguments: [record.todayTotalSaving])
                self.todayMyPlates.text = "\(record.todayMyPlates)"
                self.todayMySavings.text = String(format: "%.2f", arguments: [record.todayMySaving])
            case .failure(let error):
                print(error)
            }
        }
    }

    private func fetchChallengeEmptyPlate() {
        let request = WeeklyTopLikedEmptyPlateRequest().asURLRequest()
        challengeEmptyPlateUseCase.getResources(request: request, dataType: ChallengeEmptyPlateContainer.self) { result in
            switch result {
            case .success(let data):
                self.emptyPlateInfo = data
                self.emptyPlateCollectionView.dataSource = self
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK:- Configuration

extension HomeViewController {
    private func configure() {
        configureUI()
        configureUseCases()
        configureCollectionView()
        configureDonationProject()
        configureGestureRecognizer()
        configureTutorialView()
        configureObserver()
    }

    private func configureObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(presentClosingDetailCell), name: .selectionClosingDonationCell, object: nil)
    }

    private func configureTutorialView() {
        wholeTutorialView = WholeTutorialView()
        view.addSubview(wholeTutorialView)
        wholeTutorialView.translatesAutoresizingMaskIntoConstraints = false
        wholeTutorialView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        wholeTutorialView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        wholeTutorialView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        wholeTutorialView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        wholeTutorialView.isHidden = true
    }

    private func configureGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showTutorial(_:)))
        tutorialView.addGestureRecognizer(tapGesture)
    }

    private func configureDonationProject() {
        configureDonationProjectDataSource()
        configureDonationProjectDelegate()
        configureDonationUseCase()
    }

    private func configureDonationProjectDelegate() {
        donationProjectDelegate = ClosingDonationProjectCollectionViewDelegate(frame: view.frame.size)
        donationProjectCollectionView.delegate = donationProjectDelegate
    }

    private func configureDonationUseCase() {
        donationUseCase = DonationUseCase()
    }

    private func configureDonationProjectDataSource() {
        donationProjectDataSource = DonationProjectCollectionViewDataSource<ClosingDonationProjectCell>(
            handler: { (_) in
                self.donationProjectCollectionView.reloadData()
        })
        donationProjectCollectionView.dataSource = donationProjectDataSource
    }

    private func configureUI() {
        todayWholeView.layer.borderWidth = 0.8
        todayWholeView.layer.borderColor = UIColor(named: "key_green")?.cgColor
        todayWholeView.roundCorner(cornerRadius: 15)
        todayMyView.roundCorner(cornerRadius: 15)
        todayWholeView.drawShadow(color: .darkGray, offset: .init(width: 1, height: 1), radius: 3.0, opacity: 0.4)
        todayMyView.drawShadow(color: .darkGray, offset: .init(width: 1, height: 1), radius: 3.0, opacity: 0.4)
        personalTotalView.roundCorner(cornerRadius: 15)
        personalTotalView.drawShadow(color: .darkGray, offset: .init(width: 1, height: 1), radius: 3.0, opacity: 0.3)
        findSurroundingRestaurantView.roundCorner(cornerRadius: 10)
        findSurroundingRestaurantView.drawShadow(color: .darkGray, offset: .init(width: 1, height: 1), radius: 3.0, opacity: 0.3)
    }

    private func configureUseCases() {
        personalTotalSavingUseCase = PersonalTotalSavingUseCase()
        todayRecordUseCase = TodayRecordUseCase()
        challengeEmptyPlateUseCase = ChallengeEmptyPlateUseCase()
    }

    private func configureCollectionView() {
        emptyPlateCollectionView.register(UINib(nibName: String(describing: EmptyPlateCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: EmptyPlateCollectionViewCell.self))
    }
}
