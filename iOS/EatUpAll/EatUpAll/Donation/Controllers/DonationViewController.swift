//
//  DonationViewController.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/13.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

final class DonationViewController: UIViewController {
    
    private enum Metric {
        static let WholeDonationTopBottomPadding: CGFloat = 12.0
    }
    
    @IBOutlet weak var closingDonationProjectCollectionView: ClosingDonationProjectCollectionView!
    @IBOutlet weak var wholeDonationProjectCollectionView: DonationProjectCollectionView!
    private var closingDonationProjectDataSource: DonationProjectCollectionViewDataSource<ClosingDonationProjectCell>!
    private var wholeDonationProjectDataSource: DonationProjectCollectionViewDataSource<DonationProjectCell>!
    private var closingDonationProjectDelegate: ClosingDonationProjectCollectionViewDelegate!
    private var wholeDonationProjectDelegate: WholeDonationProjectCollectionViewDelegate!
    @IBOutlet weak var wholeDonationProjectCollectionViewHeight: NSLayoutConstraint!
    
    private var donationUseCase: DonationUseCase!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        fetchDonationProjects()
    }
    
    @objc func presentClosingDetailCell(_ notification: Notification) {
        let donationDetailViewController = DonationDetailViewController.loadFromNib()
        donationDetailViewController.modalPresentationStyle = .fullScreen

        guard let indexPath = notification.userInfo?["indexPath"] as? IndexPath else { return }
        closingDonationProjectDataSource.referDonationProject(at: indexPath) { donationProject in

        }
        present(donationDetailViewController, animated: true)
    }
    
    @objc func presentWholeDetailCell(_ notification: Notification) {
        guard let indexPath = notification.userInfo?["indexPath"] as? IndexPath else { return }
        let donationDetailViewController = DonationDetailViewController.loadFromNib()
        donationDetailViewController.modalPresentationStyle = .fullScreen

        wholeDonationProjectDataSource.referDonationProject(at: indexPath) { donationProject in

        }
        present(donationDetailViewController, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .selectionClosingDonationCell, object: nil)
        NotificationCenter.default.removeObserver(self, name: .selectionWholeDonationCell, object: nil)
    }
}

// MARK:- Fetching Projects

extension DonationViewController {
    private func fetchDonationProjects() {
        fetchClosingDonationProjects()
        fetchWholeDonationProjects()
    }
    
    private func fetchWholeDonationProjects() {
        let request = DonationWholeProjectRequest().asURLRequest()
        donationUseCase.getResources(
            request: request,
            dataType: DonationProjectContainer.self) { (result) in
                switch result {
                case .success(let wholeProjectContainer):
                    self.wholeDonationProjectDataSource.updateDonationProjects(wholeProjectContainer.data)
                case .failure(_):
                    break
                }
        }
    }
    
    private func fetchClosingDonationProjects() {
        let request = DonationClosingProjectRequest().asURLRequest()
        donationUseCase.getResources(
            request: request,
            dataType: DonationProjectContainer.self) { (result) in
                switch result {
                case .success(let closingProjectContainer):
                    self.closingDonationProjectDataSource.updateDonationProjects(closingProjectContainer.data)
                case .failure(_):
                    break
                }
        }
    }
}

// MARK:- Configuration

extension DonationViewController {
    private func configure() {
        configureNavigation()
        configureClosingDonationProjectDataSource()
        configureClosingDonationProjectDelegate()
        configureWholeDonationProjectDataSource()
        configureWholeDonationProjectDelegate()
        configureUseCase()
        configureObserver()
    }
    
    private func configureObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(presentClosingDetailCell), name: .selectionClosingDonationCell, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(presentWholeDetailCell), name: .selectionWholeDonationCell, object: nil)
    }
    
    private func configureUseCase() {
        donationUseCase = DonationUseCase()
    }
    
    private func configureNavigation() {
        navigationItem.title = "기부하기"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureClosingDonationProjectDataSource() {
        closingDonationProjectDataSource = DonationProjectCollectionViewDataSource(
            handler: { (_) in
                self.closingDonationProjectCollectionView.reloadData()
        })
        closingDonationProjectCollectionView.dataSource = closingDonationProjectDataSource
    }
    
    private func configureClosingDonationProjectDelegate() {
        closingDonationProjectDelegate = ClosingDonationProjectCollectionViewDelegate(
            frame: CGSize(width: view.frame.width, height: view.frame.height))
        closingDonationProjectCollectionView.delegate = closingDonationProjectDelegate
    }
    
    private func configureWholeDonationProjectDataSource() {
        wholeDonationProjectDataSource = DonationProjectCollectionViewDataSource(
            handler: { (_) in
                self.wholeDonationProjectCollectionView.reloadData()
                self.wholeDonationProjectCollectionView.layoutIfNeeded()
                self.wholeDonationProjectCollectionViewHeight.constant =
                    self.wholeDonationProjectCollectionView.contentSize.height + Metric.WholeDonationTopBottomPadding * 2
        })
        wholeDonationProjectCollectionView.dataSource = wholeDonationProjectDataSource
    }
    
    private func configureWholeDonationProjectDelegate() {
        wholeDonationProjectDelegate = WholeDonationProjectCollectionViewDelegate(
            frame: CGSize(width: view.frame.width, height: view.frame.height))
        wholeDonationProjectCollectionView.delegate = wholeDonationProjectDelegate
    }
}

extension Notification.Name {
    static let selectionClosingDonationCell = Notification.Name(rawValue: "selectionClosingDonationCell")
    static let selectionWholeDonationCell = Notification.Name(rawValue: "selectionWholeDonationCell")
}
