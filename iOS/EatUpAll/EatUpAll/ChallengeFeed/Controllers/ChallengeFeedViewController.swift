//
//  ChallengeFeedViewController.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/14.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

final class ChallengeFeedViewController: UIViewController {
    
    private enum Metric {
        static let numberOfCellAtRow: CGFloat = 3
        static let minimumSpacing: CGFloat = 1.0
    }

    @IBOutlet weak var collectionView: ChallengeCollectionView!
    private var dataSource: ChallengeCollectionViewDataSource!
    private var useCase: ChallengeEmptyPlateUseCase!
    
    private var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        fetchChallengeFeed()
    }
}

// MARK:- Fetching Datas

extension ChallengeFeedViewController {
    private func fetchChallengeFeed() {
        let request = AllEmptyPlateRequest().asURLRequest()
        useCase.getResources(
            request: request,
            dataType: ChallengeEmptyPlateContainer.self) { (result) in
                switch result {
                case .success(let container):
                    self.refreshControl.endRefreshing()
                    self.dataSource.configureData(container.data)
                case .failure(_):
                    break
                }
        }
    }
}

// MARK:- Configuration

extension ChallengeFeedViewController {
    private func configure() {
        configureUI()
        configureCollectionViewDataSource()
        configureCollectionViewLayout()
        configureUseCase()
        configureRefreshControl()
    }
    
    private func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(named: "key_green")
        refreshControl.addTarget(self, action: #selector(refreshChallengeFeed), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc private func refreshChallengeFeed() {
        fetchChallengeFeed()
    }
    
    private func configureUseCase() {
        useCase = ChallengeEmptyPlateUseCase()
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
        dataSource = ChallengeCollectionViewDataSource(handler: { (_) in
            self.collectionView.reloadData()
        })
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }
}

// MARK: - UICollectionViewDelegate

extension ChallengeFeedViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let challengeDetailViewController = ChallengeDetailViewController.loadFromNib()
        navigationController?.pushViewController(challengeDetailViewController, animated: true)
    }
}
