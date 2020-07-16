//
//  ChallengeDetailViewController.swift
//  EatUpAll
//
//  Created by delma on 2020/07/16.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit
import Kingfisher

class ChallengeDetailViewController: UIViewController {

    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var challengeImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    private var useCase: ChallengeEmptyPlateUseCase!
    private var id: Int?
    private var isLiked: Bool = false
    
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
        challengeImageView.kf.setImage(with: URL(string:plateInfo.image)!)
        placeLabel.text = plateInfo.restaurantName
        likeCountLabel.text = "\(plateInfo.likeCount)"
        descriptionTextView.text = plateInfo.description
        let buttonImage = UIImage(systemName: "suit.heart.fill")
        if plateInfo.isLiked == "True" {
            likeButton.setImage(buttonImage, for: .normal)
            isLiked = true
        }else { isLiked = false }
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
    
    @IBAction func switchLike(_ sender: UIButton) {
        if isLiked {
            isLiked = false
            let buttonImage = UIImage(systemName: "suit.heart")
            likeButton.setImage(buttonImage, for: .normal)
            likeCountLabel.text = String(Int(likeCountLabel.text!)! - 1)
        }else {
            isLiked = true
            let buttonImage = UIImage(systemName: "suit.heart.fill")
            likeButton.setImage(buttonImage, for: .normal)
            likeCountLabel.text = String(Int(likeCountLabel.text!)! + 1)
        }
    }
}
