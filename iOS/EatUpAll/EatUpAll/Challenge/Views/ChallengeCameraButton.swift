//
//  ChallengeCameraButton.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/15.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

final class ChallengeCameraButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
}

// MARK:- Configuration

extension ChallengeCameraButton {
    private func configure() {
        configureUI()
    }
    
    private func configureUI() {
        roundCorner(cornerRadius: self.frame.height / 2)
        drawBorder(color: .white, width: 4.0)
    }
}
