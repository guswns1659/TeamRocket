//
//  ChallengeCollectionViewDataSource.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/14.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

final class ChallengeCollectionViewDataSource: NSObject, UICollectionViewDataSource, ViewModelBinding {
    
    typealias Key = [ChallengeEmptyPlate]
    private var changedHandler: Handler
    private var challengeEmptyPlates: [ChallengeEmptyPlate] = [] {
        didSet {
            changedHandler(challengeEmptyPlates)
        }
    }
    
    init(
        with challengeEmptyPlates: [ChallengeEmptyPlate] = [],
        handler: @escaping Handler = { _ in }) {
        self.challengeEmptyPlates = challengeEmptyPlates
        self.changedHandler = handler
    }
    
    func updateNotify(handler: @escaping Handler) {
        self.changedHandler = handler
    }
    
    func configureData(_ data: [ChallengeEmptyPlate]) {
        self.challengeEmptyPlates = data
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return challengeEmptyPlates.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: ChallengeCell.self),
            for: indexPath) as! ChallengeCell
        return cell
    }
}
