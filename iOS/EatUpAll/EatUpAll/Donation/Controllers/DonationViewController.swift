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
    private var closingDonationProjectCollectionViewDataSource: ClosingDonationProjectCollectionViewDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        fetchDonationProjects()
    }
    
    private func fetchDonationProjects() {
        closingDonationProjectCollectionViewDataSource.updateDonationProjects([
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
        configureClosingDonationProjectCollectionViewDataSources()
    }
    
    private func configureNavigation() {
        navigationItem.title = "기부하기"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureClosingDonationProjectCollectionViewDataSources() {
        closingDonationProjectCollectionViewDataSource = ClosingDonationProjectCollectionViewDataSource(handler: { (_) in
            self.closingDonationProjectCollectionView.reloadData()
        })
        closingDonationProjectCollectionView.dataSource = closingDonationProjectCollectionViewDataSource
    }
}
