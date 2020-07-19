//
//  ChallengeCell.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/14.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

final class ChallengeCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shimmeringView: UIView!
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    func updateImage(_ image: UIImage?) {
        imageView.image = image
    }
    
    func startShimmeringAnimation() {
        layoutIfNeeded()
        shimmeringView.startShimmering()
    }
    
    func stopShimmeringAnimation() {
        shimmeringView.stopShimmering()
    }
}
