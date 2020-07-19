//
//  EmptyPlateCollectionViewCell.swift
//  EatUpAll
//
//  Created by delma on 2020/07/14.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

class EmptyPlateCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var emptyPlateImageView: UIImageView!
    
    func configureImage(_ image: UIImage) {
        emptyPlateImageView.image = image
    }
}
