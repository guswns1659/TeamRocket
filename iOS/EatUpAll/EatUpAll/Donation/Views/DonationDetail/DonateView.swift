//
//  DonateView.swift
//  EatUpAll
//
//  Created by delma on 2020/07/15.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

class DonateView: UIView {

    @IBOutlet var frameView: UIView!
    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var donateButton: UIButton!
    @IBOutlet weak var ecoPointLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var allDonateView: UIView!
    @IBOutlet weak var containerViewBottomAnchor: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil)
        addSubview(frameView)
        frameView.frame = self.bounds
        configureUI()
        configureGestureRecognizer()
    }
    
    private func configureUI() {
        containerView.roundCorner(cornerRadius: 15)
        donateButton.roundCorner(cornerRadius: 10)
    }
    
    private func configureGestureRecognizer() {
        let hideGesture = UITapGestureRecognizer(target: self, action: #selector(hide(recognizer:)))
        transparentView.addGestureRecognizer(hideGesture)
        
        let allDonateGesture = UITapGestureRecognizer(target: self, action: #selector(allDonate(recognizer:)))
        allDonateView.addGestureRecognizer(allDonateGesture)
    }
    
    @objc private func hide(recognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0.0
        }
        NotificationCenter.default.post(name: .inputDone, object: nil)
    }
    
    @objc private func allDonate(recognizer: UITapGestureRecognizer) {
        amountTextField.text = ecoPointLabel.text
    }
    
    @IBAction func donateButtonDidTap(_ sender: UIButton) {
        guard let inputText = amountTextField.text else { return }
        guard let ecoText = ecoPointLabel.text else { return }
        var announcement = ""
        var isPossible = false
        if inputText == "" || Int(inputText)! == 0 {
            announcement = "기부하실 포인트를 입력해주세요"
        }else if Int(inputText)! > Int(ecoText)! {
            announcement = "보유 포인트 이상 사용은 불가능합니다."
            amountTextField.text = ecoText
        } else {
            announcement = "기부되었습니다. 감사합니다!"
            isPossible = true
        }
        NotificationCenter.default.post(name: .inputDone, object: nil)
        NotificationCenter.default.post(name: .donateButtonDidTap, object: nil, userInfo: ["announcement" : (announcement, isPossible)])
    }
    
    func configureTextField(handler: (UITextField) -> Void) {
        handler(amountTextField)
    }
    
    func moveContainerView(constant: CGFloat) {
        containerViewBottomAnchor.constant = constant
        UIView.animateCurveEaseOut(withDuration: 0.5, animations: {
            self.layoutIfNeeded()
        })
    }
    
    func configureEcoPointLabel(_ point: Int) {
        ecoPointLabel.text = "\(point)"
    }
}
