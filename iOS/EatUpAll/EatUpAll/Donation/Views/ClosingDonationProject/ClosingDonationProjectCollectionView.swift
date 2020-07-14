//
//  ClosingDonationProjectCollectionView.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/13.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

final class ClosingDonationProjectCollectionView: UICollectionView {
    
    private enum Metric {
        static let sidePadding: CGFloat = 20.0
    }
    
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
        configureContentInset()
        registerCollectionViewCell()
    }
    
    private func configureContentInset() {
        contentInset = UIEdgeInsets(
            top: 0,
            left: Metric.sidePadding,
            bottom: 0,
            right: Metric.sidePadding)
    }
    
    private func configureCollectionView() {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        showsHorizontalScrollIndicator = false
    }
    
    private func registerCollectionViewCell() {
        let nib = UINib(nibName: String(describing: ClosingDonationProjectCell.self), bundle: nil)
        register(nib, forCellWithReuseIdentifier: String(describing: ClosingDonationProjectCell.self))
    }
}
