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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func backButtonDidTap(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
