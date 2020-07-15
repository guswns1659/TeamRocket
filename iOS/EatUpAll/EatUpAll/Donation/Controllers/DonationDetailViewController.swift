//
//  DonationDetailViewController.swift
//  EatUpAll
//
//  Created by delma on 2020/07/14.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit
import Kingfisher

class DonationDetailViewController: UIViewController {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var hostCompany: UILabel!
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var currentMoney: UILabel!
    @IBOutlet weak var targetMoney: UILabel!
    @IBOutlet weak var leftTime: UILabel!
    @IBOutlet weak var donatorCount: UILabel!
    @IBOutlet weak var donationRatio: UILabel!
    
    private var donationProjectDetailUseCase: DonationProjectDetailUseCase!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        donationProjectDetailUseCase = DonationProjectDetailUseCase()
    }

    @IBAction func backButtonDidTap(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    func fetchDonationDetailData(id: Int) {
        let request = DonationProjectDetailRequest(id: id).asURLRequest()
        donationProjectDetailUseCase.getResources(request: request, dataType: DonationDetail.self) { result in
            switch result {
            case .success(let donationDetail):
                self.configureData(data: donationDetail)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configureData(data: DonationDetail) {
        let url = URL(string: data.mainURL)
        mainImage.kf.setImage(with: url)
        self.hostCompany.text = data.titleWithCompany
        self.projectTitle.text = data.title
        self.currentMoney.text = "\(data.currentMoney)원"
        self.targetMoney.text = "\(data.targetMoney)원"
        self.donatorCount.text = "\(data.donators)명"
        self.leftTime.text = "\(data.leftDay)일 \(data.leftHour)시간"
        let percentage = Double(data.currentMoney) / Double(data.targetMoney)
        self.donationRatio.text = "\(Int(percentage * 100))%"
    }
}
