//
//  HomeViewController.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/13.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit
import Kingfisher

final class HomeViewController: UIViewController {

    @IBOutlet weak var emptyPlateCollectionView: UICollectionView!
    
    private var emptyPlateUseCase: EmptyPlateUseCase!
    private var emptyPlateInfo: ChallengeEmptyPlate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        emptyPlateUseCase = EmptyPlateUseCase()
        fetchEmptyPlate()
        configureCollectionView()
    }
    
    private func fetchEmptyPlate() {
        let request = EmptyPlateRequest().asURLRequest()
        emptyPlateUseCase.getResources(request: request, dataType: ChallengeEmptyPlate.self) { result in
            switch result {
            case .success(let data):
                self.emptyPlateInfo = data
                self.emptyPlateCollectionView.dataSource = self
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configureCollectionView() {
        emptyPlateCollectionView.register(UINib(nibName: String(describing: EmptyPlateCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: EmptyPlateCollectionViewCell.self))
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emptyPlateInfo.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EmptyPlateCollectionViewCell.self), for: indexPath) as! EmptyPlateCollectionViewCell
        let url = URL(string: emptyPlateInfo.data[indexPath.row].image)
        KingfisherManager.shared.retrieveImage(with: url!, options: nil, progressBlock: nil, downloadTaskUpdated: nil) { (result) in
            switch result {
            case .success(let value):
                cell.configureImage(value.image)
            case .failure(let error):
                print(error)
            }
        }
        return cell
    }
}
