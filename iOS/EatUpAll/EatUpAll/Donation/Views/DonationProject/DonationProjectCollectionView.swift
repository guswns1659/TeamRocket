//
//  DonationProjectCollectionView.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/13.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

final class DonationProjectCollectionView: UICollectionView {
    
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

extension DonationProjectCollectionView {
    private func configure() {
        backgroundColor = .blue
        configureCollectionView()
        registerCollectionViewCell()
    }
    
    private func configureCollectionView() {
        showsVerticalScrollIndicator = false
    }
    
    private func registerCollectionViewCell() {
        let nib = UINib(nibName: String(describing: DonationProjectCell.self), bundle: nil)
        register(nib, forCellWithReuseIdentifier: String(describing: DonationProjectCell.self))
    }
}
