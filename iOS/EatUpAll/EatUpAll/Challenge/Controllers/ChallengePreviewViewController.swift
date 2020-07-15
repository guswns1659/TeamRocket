//
//  ChallengePreviewViewController.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/15.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

final class ChallengePreviewViewController: UIViewController {

    @IBOutlet private var capturedImageView: UIImageView!
    
    private var capturedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCapturedImageView()
    }
    
    private func configureCapturedImageView() {
        capturedImageView.image = capturedImage
    }
    
    func configureCapturedImage(_ image: UIImage?) {
        capturedImage = image
        guard capturedImageView != nil else { return }
        configureCapturedImageView()
    }
    
    @IBAction func cancelButtonDidTap(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func saveButtonDidTap(_ sender: Any) {
        
    }
}
