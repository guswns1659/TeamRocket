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
    @IBOutlet weak var likeCountAnnouncementLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    private var likeUseCase: LikeUseCase!
    private var challengeEmptyPlateUseCase: ChallengeEmptyPlateUseCase!
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
        configureUseCase()
    }
    
    private func configureUseCase() {
        challengeEmptyPlateUseCase = ChallengeEmptyPlateUseCase()
        likeUseCase = LikeUseCase()
    }
    
    private func configureData(plateInfo: ChallengeEmptyPlate) {
        challengeImageView.kf.setImage(with: URL(string:plateInfo.image)!)
        placeLabel.text = plateInfo.restaurantName
        if plateInfo.likeCount == 0 {
            likeCountLabel.text = "0"
            likeCountLabel.isHidden = true
            likeCountAnnouncementLabel.text = "처음으로 챌린지를 응원해주세요"
        } else {
            likeCountLabel.text = "\(plateInfo.likeCount)"
            likeCountLabel.isHidden = false
            likeCountAnnouncementLabel.text = "명이 응원합니다"
        }
        descriptionTextView.text = plateInfo.description
        userLabel.text = plateInfo.author
        let buttonImage = UIImage(systemName: "suit.heart.fill")
        if plateInfo.isLiked == "True" {
            likeButton.setImage(buttonImage, for: .normal)
            isLiked = true
        }else { isLiked = false }
    }
    
    private func fetchEmptyPlate(id: Int) {
        let request = EmptyPlateRequest(id: id).asURLRequest()
        challengeEmptyPlateUseCase.getResources(request: request, dataType: ChallengeEmptyPlate.self) { result in
            switch result {
            case .success(let plateInfo):
                self.configureData(plateInfo: plateInfo)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func switchLike(_ sender: UIButton) {
        let count = Int(likeCountLabel.text!)!
        if isLiked {
            isLiked = false
            let buttonImage = UIImage(systemName: "suit.heart")
            likeButton.setImage(buttonImage, for: .normal)
            likeCountLabel.text = String(count - 1)
            likeRequest(isLiked: "False")
        }else {
            isLiked = true
            let buttonImage = UIImage(systemName: "suit.heart.fill")
            likeButton.setImage(buttonImage, for: .normal)
            likeCountLabel.text = String(count + 1)
            likeRequest(isLiked: "True")
        }
        
        if Int(likeCountLabel.text!)! == 0 {
            likeCountLabel.isHidden = true
            likeCountAnnouncementLabel.text = "처음으로 챌린지를 응원해주세요"
        } else {
            likeCountLabel.isHidden = false
            likeCountAnnouncementLabel.text = "명이 응원합니다"
        }
    }
    
    private func likeRequest(isLiked: String) {
        let request = LikeRequest(id: id!)
        request.append(name: .liked, value: isLiked)
        likeUseCase.getStatus(request: request.asURLRequest()) { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                print(error)
            }
        }
    }
}
