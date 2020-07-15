//
//  ChallengeCameraViewController.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/15.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

final class ChallengeCameraViewController: UIViewController {
    
    private var previewViewController: ChallengePreviewViewController!

    @IBOutlet weak var cameraButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    @IBAction func cameraButtonDidTap(_ sender: Any) {
        previewViewController.modalPresentationStyle = .fullScreen
        present(previewViewController, animated: false, completion: nil)
    }
}

// MARK:- Configuration

extension ChallengeCameraViewController {
    private func configure() {
        configurePreviewViewController()
    }
    
    private func configurePreviewViewController() {
        previewViewController = ChallengePreviewViewController.loadFromNib()
    }
}
