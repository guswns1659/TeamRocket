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
    @IBOutlet weak var progressBarBackgroundView: UIView!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var remainingDateLabel: UILabel!
    @IBOutlet weak var accumulatedDonationLabel: UILabel!
    @IBOutlet weak var progressPercentageLabel: UILabel!
    @IBOutlet weak var projectImageView: UIImageView!
    @IBOutlet weak var progressBarWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    func configureCell(with donationProject: DonationProject) {
        titleLabel.text = "\(donationProject.subtitle) \(donationProject.title)"
        remainingDateLabel.text = "\(donationProject.leftDays)일 남음"
        accumulatedDonationLabel.text = "\(donationProject.currentAmount.moneyFormat)원"
        let percentage = Double(donationProject.currentAmount) / Double(donationProject.goalAmount)
        progressPercentageLabel.text = "\(Int(percentage * 100))%"
        configureProgressBar(with: percentage)
    }
    
    private func configureProgressBar(with percentage: Double) {
        let maxWidth = progressBarBackgroundView.frame.width
        var progressBarWidth = maxWidth * CGFloat(percentage)
        progressBarWidth = progressBarWidth > maxWidth ? maxWidth : progressBarWidth
        progressBarWidthConstraint.constant = progressBarWidth
    }
    
    func configureTitleImage(_ image: UIImage) {
        projectImageView.image = image
    }
}

// MARK:- Configuration

extension DonationProjectCell {
    private func configure() {
        configureUI()
        configureProgressBars()
    }
    
    private func configureProgressBars() {
        progressBarView.roundCorner(cornerRadius: 2.0)
        progressBarBackgroundView.roundCorner(cornerRadius: 2.0)
    }
    
    private func configureUI() {
        containerView.roundCorner(cornerRadius: 8.0)
        containerView.clipsToBounds = true
        drawShadow(color: .darkGray, offset: .init(width: 1, height: 1), radius: 3.0, opacity: 0.3)
    }
}
