//
//  DonationProjectCollectionViewDataSource.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/14.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit
import Kingfisher

final class DonationProjectCollectionViewDataSource<T: DonationProjectConfigurable>: NSObject, UICollectionViewDataSource, ViewModelBinding {
    
    typealias Key = [DonationProject]
    private var changedHandler: Handler
    private var donationProjects: [DonationProject] = [] {
        didSet {
            changedHandler(donationProjects)
        }
    }
    
    init(
        with donationProjects: [DonationProject] = [],
        handler: @escaping Handler = { _ in }) {
        self.donationProjects = donationProjects
        self.changedHandler = handler
    }
    
    func updateNotify(handler: @escaping Handler) {
        self.changedHandler = handler
    }
    
    func updateDonationProjects(_ donationProjects: [DonationProject]) {
        self.donationProjects = donationProjects
    }
    
    func referDonationProject(at indexPath: IndexPath, handler: (DonationProject) -> Void ) {
        let donationProject = donationProjects[indexPath.item]
        handler(donationProject)
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
            withReuseIdentifier: String(describing: T.self),
            for: indexPath) as! T
        let project = donationProjects[indexPath.item]
        let titleImageURL = URL(string: project.imageURLs.first!)!
        cell.configureCell(with: project)
        KingfisherManager.shared.retrieveImage(with: titleImageURL) { (result) in
            switch result {
            case .success(let retrieveImageResult):
                cell.configureTitleImage(retrieveImageResult.image)
            case .failure(_):
                break
            }
        }
        return cell
    }
}

