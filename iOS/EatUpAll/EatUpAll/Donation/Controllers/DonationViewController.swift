//
//  DonationViewController.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/13.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

final class DonationViewController: UIViewController {
    
    @IBOutlet weak var closingDonationProjectCollectionView: ClosingDonationProjectCollectionView!
    @IBOutlet weak var wholeDonationProjectCollectionView: DonationProjectCollectionView!
    private var closingDonationProjectDataSource: DonationProjectCollectionViewDataSource<ClosingDonationProjectCell>!
    private var wholeDonationProjectDataSource: DonationProjectCollectionViewDataSource<DonationProjectCell>!
    private var closingDonationProjectDelegate: ClosingDonationProjectCollectionViewDelegate!
    private var wholeDonationProjectDelegate: WholeDonationProjectCollectionViewDelegate!
    @IBOutlet weak var wholeDonationProjectCollectionViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        fetchClosingDonationProjects()
        fetchDonationProjects()
    }
    
    private func fetchClosingDonationProjects() {
        closingDonationProjectDataSource.updateDonationProjects([
            DonationProject(title: "1111", subtitle: "22222", deadline: Date(), numberOfDonations: 3, currentAmount: 100000, goalAmount: 100000000),
            DonationProject(title: "1111", subtitle: "22222", deadline: Date(), numberOfDonations: 3, currentAmount: 100000, goalAmount: 100000000),
            DonationProject(title: "1111", subtitle: "22222", deadline: Date(), numberOfDonations: 3, currentAmount: 100000, goalAmount: 100000000),
            DonationProject(title: "1111", subtitle: "22222", deadline: Date(), numberOfDonations: 3, currentAmount: 100000, goalAmount: 100000000),
            DonationProject(title: "1111", subtitle: "22222", deadline: Date(), numberOfDonations: 3, currentAmount: 100000, goalAmount: 100000000),
            DonationProject(title: "1111", subtitle: "22222", deadline: Date(), numberOfDonations: 3, currentAmount: 100000, goalAmount: 100000000),
            DonationProject(title: "1111", subtitle: "22222", deadline: Date(), numberOfDonations: 3, currentAmount: 100000, goalAmount: 100000000),
            DonationProject(title: "1111", subtitle: "22222", deadline: Date(), numberOfDonations: 3, currentAmount: 100000, goalAmount: 100000000),
            DonationProject(title: "1111", subtitle: "22222", deadline: Date(), numberOfDonations: 3, currentAmount: 100000, goalAmount: 100000000)])
    }
    
    private func fetchDonationProjects() {
        wholeDonationProjectDataSource.updateDonationProjects([
            DonationProject(title: "1111", subtitle: "22222", deadline: Date(), numberOfDonations: 3, currentAmount: 100000, goalAmount: 100000000),
            DonationProject(title: "1111", subtitle: "22222", deadline: Date(), numberOfDonations: 3, currentAmount: 100000, goalAmount: 100000000),
            DonationProject(title: "1111", subtitle: "22222", deadline: Date(), numberOfDonations: 3, currentAmount: 100000, goalAmount: 100000000),
            DonationProject(title: "1111", subtitle: "22222", deadline: Date(), numberOfDonations: 3, currentAmount: 100000, goalAmount: 100000000),
            DonationProject(title: "1111", subtitle: "22222", deadline: Date(), numberOfDonations: 3, currentAmount: 100000, goalAmount: 100000000),
            DonationProject(title: "1111", subtitle: "22222", deadline: Date(), numberOfDonations: 3, currentAmount: 100000, goalAmount: 100000000),
            DonationProject(title: "1111", subtitle: "22222", deadline: Date(), numberOfDonations: 3, currentAmount: 100000, goalAmount: 100000000),
            DonationProject(title: "1111", subtitle: "22222", deadline: Date(), numberOfDonations: 3, currentAmount: 100000, goalAmount: 100000000),
            DonationProject(title: "1111", subtitle: "22222", deadline: Date(), numberOfDonations: 3, currentAmount: 100000, goalAmount: 100000000)])
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
                self.wholeDonationProjectCollectionViewHeight.constant = self.wholeDonationProjectCollectionView.contentSize.height
        })
        wholeDonationProjectCollectionView.dataSource = wholeDonationProjectDataSource
    }
    
    private func configureWholeDonationProjectDelegate() {
        wholeDonationProjectDelegate = WholeDonationProjectCollectionViewDelegate(
            frame: CGSize(width: view.frame.width, height: view.frame.height))
        wholeDonationProjectCollectionView.delegate = wholeDonationProjectDelegate
    }
}
