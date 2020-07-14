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

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    private func configure() {
        emptyPlateImageView.roundCorner(cornerRadius: 20)
    }
    
    func configureImage(_ image: UIImage) {
        emptyPlateImageView.image = image
    }
}
