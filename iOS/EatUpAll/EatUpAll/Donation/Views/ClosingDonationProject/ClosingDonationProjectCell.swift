//
//  ClosingDonationProjectCell.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/13.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

final class ClosingDonationProjectCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    
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
        containerView.roundCorner(cornerRadius: 8.0)
        containerView.clipsToBounds = true
        drawShadow(color: .darkGray, offset: .init(width: 1, height: 1), radius: 3.0, opacity: 0.4)
    }
}
