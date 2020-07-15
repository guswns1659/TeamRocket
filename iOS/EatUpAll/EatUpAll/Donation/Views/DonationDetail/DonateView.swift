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
        amountTextField.text = ""
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
    
    func configureTextField(handler: (UITextField) -> Void) {
        handler(amountTextField)
    }
    
    func moveContainerView(constant: CGFloat) {
        containerViewBottomAnchor.constant = constant
        UIView.animateCurveEaseOut(withDuration: 0.5, animations: {
            self.layoutIfNeeded()
        })
    }
}
