//
//  TutorialFirstView.swift
//  EatUpAll
//
//  Created by delma on 2020/07/17.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

final class TutorialFirstView: UIView {
    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    
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
    }
    
    private func configureUI() {
        nextButton.layer.borderColor = UIColor(named: "key_green")?.cgColor
        nextButton.layer.borderWidth = 1
        nextButton.roundCorner(cornerRadius: 10)
        frameView.roundCorner(cornerRadius: 10)
    }
}
