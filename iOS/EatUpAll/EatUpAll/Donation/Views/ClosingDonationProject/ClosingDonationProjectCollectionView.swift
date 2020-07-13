//
//  ClosingDonationProjectCollectionView.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/13.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

final class ClosingDonationProjectCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
}

// MARK:- Configuration

extension ClosingDonationProjectCollectionView {
    private func configure() {
        backgroundColor = .red
        configureCollectionView()
        registerCollectionViewCell()
    }
    
    private func configureCollectionView() {
        showsHorizontalScrollIndicator = false
    }
    
    private func registerCollectionViewCell() {
        let nib = UINib(nibName: String(describing: ClosingDonationProjectCell.self), bundle: nil)
        register(nib, forCellWithReuseIdentifier: String(describing: ClosingDonationProjectCell.self))
    }
}
