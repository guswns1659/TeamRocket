//
//  DonationDetailViewController.swift
//  EatUpAll
//
//  Created by delma on 2020/07/14.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit
import Kingfisher

class DonationDetailViewController: UIViewController {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var hostCompany: UILabel!
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var currentMoney: UILabel!
    @IBOutlet weak var targetMoney: UILabel!
    @IBOutlet weak var leftTime: UILabel!
    @IBOutlet weak var donatorCount: UILabel!
    @IBOutlet weak var donationRatio: UILabel!
    @IBOutlet weak var descriptionStackView: UIStackView!
    @IBOutlet weak var donationButton: UIButton!
    
    private var donateView: DonateView!
    private var descriptionImages: [UIImage] = []
    private var donationProjectDetailUseCase: DonationProjectDetailUseCase!
    private let toolBarKeyBoard = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    private func configure() {
        configureUI()
        configureUseCase()
        configureDonateView()
        configureKeyboardNotification()
        configureToolbar()
    }
    
    private func configureUI() {
        donationButton.roundCorner(cornerRadius: 10)
    }
        
    private func configureUseCase() {
        donationProjectDetailUseCase = DonationProjectDetailUseCase()
    }

    private func configureDonateView() {
        donateView = DonateView()
        donateView.configureTextField { $0.inputAccessoryView = toolBarKeyBoard }
        donateView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(donateView)
        donateView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        donateView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        donateView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        donateView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        donateView.alpha = 0
    }

    @IBAction func donationButtonDidTap(_ sender: UIButton) {
        donateView.alpha = 1
    }
    
    @IBAction func backButtonDidTap(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    func fetchDonationDetailData(id: Int) {
        let request = DonationProjectDetailRequest(id: id).asURLRequest()
        donationProjectDetailUseCase.getResources(request: request, dataType: DonationDetail.self) { result in
            switch result {
            case .success(let donationDetail):
                self.configureData(data: donationDetail)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configureData(data: DonationDetail) {
        let url = URL(string: data.mainURL)
        mainImage.kf.setImage(with: url)
        hostCompany.text = data.titleWithCompany
        projectTitle.text = data.title
        currentMoney.text = "\(data.currentMoney)원"
        targetMoney.text = "\(data.targetMoney)원"
        donatorCount.text = "\(data.donators)명"
        leftTime.text = "\(data.leftDay)일 \(data.leftHour)시간"
        let percentage = Double(data.currentMoney) / Double(data.targetMoney)
        self.donationRatio.text = "\(Int(percentage * 100))%"
        configureDescriptionStackView(images: data.descriptionURL)
    }
    
    private func configureDescriptionStackView(images: [String]) {
        descriptionImages = []
        images.forEach { generateDescriptionImages(imageURL: $0) }
        descriptionStackView.subviews.forEach { $0.removeFromSuperview() }
        descriptionImages.forEach {
            let imageView = UIImageView(image: $0)
            descriptionStackView.addArrangedSubview(imageView)
        }
    }
    
    private func generateDescriptionImages(imageURL: String) {
        let url = URL(string:imageURL)
        KingfisherManager.shared.retrieveImage(with: url!, options: nil, progressBlock: nil, downloadTaskUpdated: nil) { (result) in
            switch result {
            case .success(let value):
                self.descriptionImages.append(value.image)
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK:- Keyboard

extension DonationDetailViewController {
    
    private func configureKeyboardNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            	object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        donateView.moveContainerView(constant: keyboardFrame.cgRectValue.height)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        donateView.moveContainerView(constant: 0)
    }
    
    private func configureToolbar() {
        toolBarKeyBoard.sizeToFit()
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneButtonDidTap(sender:)))
        toolBarKeyBoard.items = [doneButton]
        toolBarKeyBoard.tintColor = UIColor(named: "key_green")
    }
    
    @objc private func doneButtonDidTap(sender: UIButton) {
        view.endEditing(true)
    }
}
