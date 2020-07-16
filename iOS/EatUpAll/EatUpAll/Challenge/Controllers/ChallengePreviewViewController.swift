//
//  ChallengePreviewViewController.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/15.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

final class ChallengePreviewViewController: UIViewController {

    @IBOutlet weak var NewPostNavigationBar: UIView!
    @IBOutlet private var capturedImageView: UIImageView!
    @IBOutlet weak var descriptionContainerBackgroundView: UIView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionBackgroundView: UIView!
    @IBOutlet weak var originDescriptionTopConstraint: NSLayoutConstraint!
    private var newDescriptionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionModeNavigationBar: UIView!
    @IBOutlet weak var descriptionModeNavigationBarTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var descriptionPlaceholderLabel: UILabel!
    
    private var isDescriptionMode: Bool = false
    
    private var capturedImage: UIImage?
    
    private let maximumNumberOfText: Int = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetPreviewController()
        configureTopConstraint()
        descriptionTextView.delegate = self
    }
    
    private func resetPreviewController() {
        descriptionTextView.text = ""
        descriptionPlaceholderLabel.isHidden = false
    }
    
    func configureCapturedImage(_ image: UIImage?) {
        capturedImage = image
        guard capturedImageView != nil else { return }
        configureCapturedImageView()
    }
    
    @IBAction func cancelButtonDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shareButtonDidTap(_ sender: Any) {
        
    }
    
    @IBAction func descriptionCancelButtonDidTap(_ sender: Any) {
        dismissDescriptionMode()
    }
    
    @IBAction func descriptionDoneButtonDidTap(_ sender: Any) {
        dismissDescriptionMode()
    }
}

extension ChallengePreviewViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 0 {
            descriptionPlaceholderLabel.isHidden = true
        }
    }
    
    func textView(
        _ textView: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText text: String) -> Bool {
        guard let nsText = textView.text as NSString? else { return false }
        let newString = nsText.replacingCharacters(in: range, with: text)
        return newString.count <= maximumNumberOfText
    }
}

// MARK:- Description Mode

extension ChallengePreviewViewController {
    private func configureTopConstraint() {
        newDescriptionViewTopConstraint = NSLayoutConstraint(
            item: descriptionView!,
            attribute: .top,
            relatedBy: .equal,
            toItem: NewPostNavigationBar,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0)
        descriptionModeNavigationBarTopConstraint.constant = -52
    }
    
    private func toDescriptionMode() {
        guard !isDescriptionMode else { return }
        isDescriptionMode = true
        
        descriptionTextView.becomeFirstResponder()
        
        if originDescriptionTopConstraint != nil {
            originDescriptionTopConstraint.isActive = false
        }
        
        descriptionTextView.isHidden = false
        descriptionBackgroundView.isHidden = false
        descriptionBackgroundView.alpha = 0
        setOriginDescriptionViewTopConstraint(to: false)
        newDescriptionViewTopConstraint.isActive = true
        descriptionModeNavigationBar.isHidden = false
        descriptionModeNavigationBarTopConstraint.constant = 0
        UIView.animateCurveEaseOut(withDuration: 0.5, animations: {
            self.descriptionBackgroundView.alpha = 0.8
            self.descriptionContainerBackgroundView.backgroundColor = .clear
            self.descriptionModeNavigationBar.alpha = 1
            self.view.layoutIfNeeded()
        })
    }
    
    private func dismissDescriptionMode() {
        guard isDescriptionMode else { return }
        isDescriptionMode = false
        
        self.view.endEditing(true)
        
        newDescriptionViewTopConstraint.isActive = false
        setOriginDescriptionViewTopConstraint(to: true)
        descriptionModeNavigationBarTopConstraint.constant = -52
        UIView.animateCurveEaseOut(withDuration: 0.5, animations: {
            self.descriptionBackgroundView.alpha = 0
            self.descriptionContainerBackgroundView.backgroundColor = .white
            self.descriptionModeNavigationBar.alpha = 0
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.descriptionBackgroundView.isHidden = true
            self.descriptionModeNavigationBar.isHidden = true
        })
    }
    
    private func setOriginDescriptionViewTopConstraint(to active: Bool) {
        NSLayoutConstraint(
            item: descriptionView!,
            attribute: .top,
            relatedBy: .equal,
            toItem: NewPostNavigationBar,
            attribute: .bottom,
            multiplier: 1.0,
            constant: view.frame.width).isActive = active
    }
}

// MARK:- Configuration

extension ChallengePreviewViewController {
    private func configure() {
        configureCapturedImageView()
        configureDescriptionTapRecognizer()
    }
    
    private func configureDescriptionTapRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(descriptionViewDidTap))
        descriptionView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func descriptionViewDidTap() {
        toDescriptionMode()
    }
    
    private func configureCapturedImageView() {
        capturedImageView.image = capturedImage
    }
}
