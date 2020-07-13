//
//  ClosingDonationProjectCell.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/13.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

final class ClosingDonationProjectCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
            
        configure()
    }
}

// MARK:- Configuration

extension ClosingDonationProjectCell {
    private func configure() {
        configureUI()
    }
    
    private func configureUI() {
        roundCorner(cornerRadius: 8.0)
        drawShadow(color: .darkGray, offset: .init(width: 0.1, height: 0.1), radius: 3.0, opacity: 0.7)
        clipsToBounds = true
    }
}
