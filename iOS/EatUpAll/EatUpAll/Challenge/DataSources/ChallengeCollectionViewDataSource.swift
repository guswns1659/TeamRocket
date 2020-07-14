//
//  ChallengeCollectionViewDataSource.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/14.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

final class ChallengeCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        16
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
