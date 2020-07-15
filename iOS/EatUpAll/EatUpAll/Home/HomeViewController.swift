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

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var personalTotalView: UIView!
    @IBOutlet weak var personalTotalSavings: UILabel!
    @IBOutlet weak var todayWholePlates: UILabel!
    @IBOutlet weak var todayWholeSavings: UILabel!
    @IBOutlet weak var todayMyPlates: UILabel!
    @IBOutlet weak var todayMySavings: UILabel!
    @IBOutlet weak var emptyPlateCollectionView: UICollectionView!
    @IBOutlet weak var donationProjectCollectionView: ClosingDonationProjectCollectionView!
    
    private var personalTotalSavingUseCase: PersonalTotalSavingUseCase!
    private var todayRecordUseCase: TodayRecordUseCase!
    private var emptyPlateUseCase: EmptyPlateUseCase!
    private var emptyPlateInfo: ChallengeEmptyPlate!
    private var donationProjectDataSource: DonationProjectCollectionViewDataSource<ClosingDonationProjectCell>!
    private var donationProjectDelegate: ClosingDonationProjectCollectionViewDelegate!
    private var donationUseCase: DonationUseCase!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        fetchDatas()
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emptyPlateInfo.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EmptyPlateCollectionViewCell.self), for: indexPath) as! EmptyPlateCollectionViewCell
        let url = URL(string: emptyPlateInfo.data[indexPath.row].url)
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
        fetchEmptyPlate()
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
                self.personalTotalSavings.text = "\(data.totalSaving)"
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
    
    private func fetchEmptyPlate() {
        let request = EmptyPlateRequest().asURLRequest()
        emptyPlateUseCase.getResources(request: request, dataType: ChallengeEmptyPlate.self) { result in
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
        personalTotalView.roundCorner(cornerRadius: 15)
        personalTotalView.drawShadow(color: .darkGray, offset: .init(width: 1, height: 1), radius: 3.0, opacity: 0.3)
    }
    
    private func configureUseCases() {
        personalTotalSavingUseCase = PersonalTotalSavingUseCase()
        todayRecordUseCase = TodayRecordUseCase()
        emptyPlateUseCase = EmptyPlateUseCase()
    }
    
    private func configureCollectionView() {
        emptyPlateCollectionView.register(UINib(nibName: String(describing: EmptyPlateCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: EmptyPlateCollectionViewCell.self))
    }
}
