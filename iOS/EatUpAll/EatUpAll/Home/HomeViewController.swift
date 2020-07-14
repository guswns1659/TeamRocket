//
//  HomeViewController.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/13.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var emptyPlateCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        emptyPlateCollectionView.register(UINib(nibName: String(describing: EmptyPlateCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: EmptyPlateCollectionViewCell.self))
        emptyPlateCollectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EmptyPlateCollectionViewCell.self), for: indexPath) as! EmptyPlateCollectionViewCell
        cell.configureImage(UIImage(named: "logo")!)
        return cell
    }
}
