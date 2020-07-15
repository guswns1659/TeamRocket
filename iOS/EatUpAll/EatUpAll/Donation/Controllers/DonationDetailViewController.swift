//
//  DonationDetailViewController.swift
//  EatUpAll
//
//  Created by delma on 2020/07/14.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

class DonationDetailViewController: UIViewController {

    @IBOutlet weak var hostCompany: UILabel!
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var currentMoney: UILabel!
    @IBOutlet weak var targetMoney: UILabel!
    @IBOutlet weak var leftTime: UILabel!
    @IBOutlet weak var donatorCount: UILabel!
    
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
                self.hostCompany.text = donationDetail.titleWithCompany
                self.projectTitle.text = donationDetail.title
                self.currentMoney.text = "\(donationDetail.currentMoney)"
                self.targetMoney.text = "\(donationDetail.targetMoney)"
                self.donatorCount.text = "\(donationDetail.donators)"
                self.leftTime.text = "\(donationDetail.leftDay)일 \(donationDetail.leftHour)시간"
            case .failure(let error):
                print(error)
            }
        }
    }
}
