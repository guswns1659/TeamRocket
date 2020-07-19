//
//  ChallengePointViewController.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/19.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

final class ChallengePointViewController: UIViewController {

    @IBOutlet weak var backgroundDarkView: UIView!
    @IBOutlet weak var ecoPointLabel: UILabel!
    @IBOutlet weak var popUpViewCenterYConstraint: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        backgroundDarkView.alpha = 0
        popUpViewCenterYConstraint.constant = 1000
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        popUpViewCenterYConstraint.constant = 0
        
        UIView.animateCurveEaseOut(withDuration: 0.3, animations: {
            self.backgroundDarkView.alpha = 0.7
            self.view.layoutIfNeeded()
        })
    }
    
    func configureEcoPoints(with mode: ChallengeCameraViewController.Mode) {
        switch mode {
        case .challengeMode:
            ecoPointLabel.text = "200"
        case .QRMode:
            ecoPointLabel.text = "400"
        }
    }
    
    @IBAction func doneButtonDidTap(_ sender: Any) {
        popUpViewCenterYConstraint.constant = 1000
        
        UIView.animateCurveEaseOut(withDuration: 0.3, animations: {
            self.backgroundDarkView.alpha = 0
            self.view.layoutIfNeeded()
        }) { (_) in
            self.dismiss(animated: false, completion: nil)
        }
    }
}
