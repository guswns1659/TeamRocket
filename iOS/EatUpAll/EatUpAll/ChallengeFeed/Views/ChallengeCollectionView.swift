//
//  ChallengeCollectionView.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/14.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

final class ChallengeCollectionView: UICollectionView {

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

extension ChallengeCollectionView {
    private func configure() {
        configureUI()
        configureCollectionView()
//        configureContentInset()
        registerCollectionViewCell()
    }
    
    private func configureUI() {
//        backgroundColor = .clear
    }
    
    private func configureCollectionView() {
        showsVerticalScrollIndicator = false
    }
    
    private func registerCollectionViewCell() {
        let nib = UINib(nibName: String(describing: ChallengeCell.self), bundle: nil)
        register(nib, forCellWithReuseIdentifier: String(describing: ChallengeCell.self))
    }
}
