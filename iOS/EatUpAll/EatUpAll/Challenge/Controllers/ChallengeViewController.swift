//
//  ChallengeViewController.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/14.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

final class ChallengeViewController: UIViewController {

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
    }
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    private func configureCollectionViewDataSource() {
        dataSource = ChallengeCollectionViewDataSource()
        collectionView.dataSource = dataSource
    }
}
