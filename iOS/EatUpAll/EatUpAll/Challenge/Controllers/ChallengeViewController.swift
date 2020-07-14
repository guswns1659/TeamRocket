//
//  ChallengeViewController.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/14.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

final class ChallengeViewController: UIViewController {
    
    private enum Metric {
        static let numberOfCellAtRow: CGFloat = 3
        static let minimumSpacing: CGFloat = 1.0
    }

    @IBOutlet weak var collectionView: ChallengeCollectionView!
    private var dataSource: ChallengeCollectionViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
}

// MARK:- Configuration

extension ChallengeViewController {
    private func configure() {
        configureUI()
        configureCollectionViewDataSource()
        configureCollectionViewLayout()
    }
    
    private func configureCollectionViewLayout() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = Metric.minimumSpacing
        layout.minimumInteritemSpacing = Metric.minimumSpacing
        let width = view.frame.width
        let cellWidth = (width - (Metric.numberOfCellAtRow + 1) * Metric.minimumSpacing) / Metric.numberOfCellAtRow
        layout.itemSize = CGSize(
            width: cellWidth,
            height: cellWidth)
    }
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    private func configureCollectionViewDataSource() {
        dataSource = ChallengeCollectionViewDataSource()
        collectionView.dataSource = dataSource
    }
}
