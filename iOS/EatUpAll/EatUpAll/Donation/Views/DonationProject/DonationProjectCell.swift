//
//  DonationProjectCell.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/13.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

final class DonationProjectCell: UICollectionViewCell, DonationProjectConfigurable {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var progressBar: UIView!
    @IBOutlet weak var progressBarBackgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var remainingDateLabel: UILabel!
    @IBOutlet weak var accumulatedDonationLabel: UILabel!
    @IBOutlet weak var progressPercentageLabel: UILabel!
    @IBOutlet weak var projectImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    func configureCell(with donationProject: DonationProject) {
        
    }
    
    func configureTitleImage(_ image: UIImage) {
        
    }
}

// MARK:- Configuration

extension DonationProjectCell {
    private func configure() {
        configureUI()
        configureProgressBars()
    }
    
    private func configureProgressBars() {
        progressBar.roundCorner(cornerRadius: 2.0)
        progressBarBackgroundView.roundCorner(cornerRadius: 2.0)
    }
    
    private func configureUI() {
        containerView.roundCorner(cornerRadius: 8.0)
        containerView.clipsToBounds = true
        drawShadow(color: .darkGray, offset: .init(width: 1, height: 1), radius: 3.0, opacity: 0.3)
    }
}
