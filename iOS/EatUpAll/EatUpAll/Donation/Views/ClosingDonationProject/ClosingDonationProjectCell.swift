//
//  ClosingDonationProjectCell.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/13.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

protocol DonationProjectConfigurable: UICollectionViewCell {
    func configureCell(with donationProject: DonationProject)
    func configureTitleImage(_ image: UIImage)
}

final class ClosingDonationProjectCell: UICollectionViewCell, DonationProjectConfigurable {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var remainingDateLabel: UILabel!
    @IBOutlet weak var accumulatedDonationLabel: UILabel!
    @IBOutlet weak var progressPercentageLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
            
        configure()
    }
    
    func configureCell(with donationProject: DonationProject) {
        titleLabel.text = donationProject.title
        subtitleLabel.text = donationProject.subtitle
        remainingDateLabel.text = "\(donationProject.leftDays)일 남음"
        accumulatedDonationLabel.text = "\(donationProject.currentAmount.moneyFormat)원"
        let percentage = Double(donationProject.currentAmount) / Double(donationProject.goalAmount)
        progressPercentageLabel.text = "\(Int(percentage * 100))%"
    }
    
    func configureTitleImage(_ image: UIImage) {
        imageView.image = image
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
