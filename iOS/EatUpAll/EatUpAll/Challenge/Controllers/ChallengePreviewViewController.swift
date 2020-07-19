//
//  ChallengePreviewViewController.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/15.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit
import JGProgressHUD

protocol ChallengePreviewViewControllerDelegate: class {
    func didSuccessToUploadChallenge()
}

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
    
    @IBOutlet weak var restaurantInfoView: UIView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    private var currentMode: ChallengeCameraViewController.Mode = .challengeMode
    private var currentRestaurantID: Int?
    
    private var uploadUseCase: ChallengeNewPostUseCase!
    private var networkUseCase: NetworkUseCase!
    
    private var isDescriptionMode: Bool = false
    
    private var capturedImage: UIImage?
    
    private let maximumNumberOfText: Int = 200
    
    let uploadingHUD = JGProgressHUD(style: .extraLight)
    
    weak var delegate: ChallengePreviewViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetPreviewController()
        configureTopConstraint()
        descriptionTextView.delegate = self
        modeDidChange()
        fetchRestaurantInfo()
    }
    
    func configureRestaurantID(_ id: Int?) {
        self.currentRestaurantID = id
    }
    
    private func fetchRestaurantInfo() {
        guard currentMode == .QRMode else { return }
        guard let restaurantID = currentRestaurantID else { return }
        let request = RestaurantInfoRequest(restaurantID: restaurantID).asURLRequest()
        networkUseCase.getResources(
            request: request,
            dataType: Restaurant.self) { (result) in
                switch result {
                case .success(let restaurant):
                    self.restaurantNameLabel.text = restaurant.name
                    self.restaurantNameLabel.sizeToFit()
                    self.restaurantInfoView.layoutIfNeeded()
                case .failure(_):
                    self.restaurantNameLabel.text = ""
                    break
                }
        }
    }
    
    func configureMode(to mode: ChallengeCameraViewController.Mode) {
        currentMode = mode
    }
    
    private func modeDidChange() {
        switch currentMode {
        case .challengeMode:
            restaurantInfoView.isHidden = true
        case .QRMode:
            restaurantInfoView.isHidden = false
        }
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
        uploadChallenge()
    }
    
    @IBAction func descriptionCancelButtonDidTap(_ sender: Any) {
        dismissDescriptionMode()
    }
    
    @IBAction func descriptionDoneButtonDidTap(_ sender: Any) {
        dismissDescriptionMode()
    }
    
    private func uploadChallenge() {
        guard let imageData = capturedImage?.jpegData(compressionQuality: 0.5) else { return }
        let description: String = descriptionTextView.text.count == 0 ? " " : descriptionTextView.text
        let uploadParameter: [String : Any] = ["description": description as Any]
        uploadingHUD.textLabel.text = "업로딩 중"
        uploadingHUD.show(in: view, animated: true)
        uploadUseCase.upload(
            restaurantID: currentRestaurantID,
            imageData: imageData,
            parameters: uploadParameter,
            completion: { isSuccess in
                if isSuccess {
                    self.uploadingHUD.dismiss(animated: true)
                    self.dismiss(animated: true, completion: {
                        self.delegate?.didSuccessToUploadChallenge()
                        self.navigationController?.popToRootViewController(animated: false)
                    })
                } else {
                    self.uploadingHUD.dismiss(animated: true)
                    self.showHUDWithError()
                }
        })
    }
    
    private func showHUDWithError() {
        let hud = JGProgressHUD(style: .extraLight)
        hud.textLabel.text = "네트워크 오류"
        hud.detailTextLabel.text = "다시 시도해주세요"
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 2.5)
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
        configureUseCase()
    }
    
    private func configureUseCase() {
        uploadUseCase = ChallengeNewPostUseCase()
        networkUseCase = NetworkUseCase()
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
