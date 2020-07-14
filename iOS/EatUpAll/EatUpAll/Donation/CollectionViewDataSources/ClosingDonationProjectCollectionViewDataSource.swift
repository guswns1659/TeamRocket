//
//  ClosingDonationProjectCollectionViewDataSource.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/13.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

final class ClosingDonationProjectCollectionViewDataSource: NSObject, UICollectionViewDataSource, ViewModelBinding {
    
    typealias Key = [DonationProject]
    private var changedHandler: Handler
    private var donationProjects: [DonationProject] = [] {
        didSet {
            changedHandler(donationProjects)
        }
    }
    
    init(with donationProjects: [DonationProject] = [], handler: @escaping Handler = { _ in }) {
        self.donationProjects = donationProjects
        self.changedHandler = handler
    }
    
    func updateNotify(handler: @escaping Handler) {
        self.changedHandler = handler
    }
    
    func updateDonationProjects(_ donationProjects: [DonationProject]) {
        self.donationProjects = donationProjects
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return donationProjects.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: ClosingDonationProjectCell.self),
            for: indexPath) as! ClosingDonationProjectCell
        return cell
    }
}