//
//  ChallengeDetailViewController.swift
//  EatUpAll
//
//  Created by delma on 2020/07/16.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

class ChallengeDetailViewController: UIViewController {

    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var challengeImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    private var useCase: ChallengeEmptyPlateUseCase!
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        fetchEmptyPlate(id: id!)
    }
    
    func configureID(_ id: Int) {
        self.id = id
    }
    
    private func configure() {
        useCase = ChallengeEmptyPlateUseCase()
    }
    
    private func configureData(plateInfo: ChallengeEmptyPlate) {
        placeLabel.text = plateInfo.restaurantName
        likeCountLabel.text = "\(plateInfo.likeCount)"
        descriptionTextView.text = plateInfo.description
        let image = UIImage(systemName: "suit.heart.fill")
        plateInfo.isLiked == "True" ? likeButton.setImage(image, for: .normal) : nil
    }
    
    private func fetchEmptyPlate(id: Int) {
        let request = EmptyPlateRequest(id: id).asURLRequest()
        useCase.getResources(request: request, dataType: ChallengeEmptyPlate.self) { result in
            switch result {
            case .success(let plateInfo):
                self.configureData(plateInfo: plateInfo)
            case .failure(let error):
                print(error)
            }
        }
    }
}
