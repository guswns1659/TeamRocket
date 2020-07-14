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
    private var closingDonationProjectDataSource: ClosingDonationProjectCollectionViewDataSource!
    private var closingDonationProjectDelegate: ClosingDonationProjectCollectionViewDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        fetchDonationProjects()
    }
    
    private func fetchDonationProjects() {
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
}

// MARK:- Configuration

extension DonationViewController {
    private func configure() {
        configureNavigation()
        configureClosingDonationProjectDataSources()
        configureClosingDonationProjectDelegate()
    }
    
    private func configureNavigation() {
        navigationItem.title = "기부하기"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureClosingDonationProjectDataSources() {
        closingDonationProjectDataSource = ClosingDonationProjectCollectionViewDataSource(
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
}
