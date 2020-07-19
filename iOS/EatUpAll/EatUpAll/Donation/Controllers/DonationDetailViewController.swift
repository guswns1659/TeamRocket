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
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    private var donationDetail: DonationDetail!
    private var donateView: DonateView!
    private var descriptionImages: [UIImage] = []
    private var donationProjectDetailUseCase: DonationProjectDetailUseCase!
    private var donationUseCase: DonationUseCase!
    private var myEcoPointUseCase: MyEcoPointUseCase!
    private let toolBarKeyBoard = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        configure()
    }
    
    @objc private func showAlert(_ notification: Notification) {
        guard let info = notification.userInfo?["announcement"] as? (String, Bool, String) else { return }
        info.1 ? requestDonation(id: donationDetail.id, point: info.2) : nil
        
        let alertController = UIAlertController(title: "알림", message: info.0, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            if info.1 {
                UIView.animate(withDuration: 0.3) {
                    self.donateView.alpha = 0.0
                }
            }
        }
        alertController.addAction(ok)
        present(alertController, animated: true)
    }
    
    @IBAction func donationButtonDidTap(_ sender: UIButton) {
        donateView.resetAmount()
        fetchMyEcoPoint()
        UIView.animate(withDuration: 0.3) {
            self.donateView.alpha = 1.0
        }
    }
    
    @IBAction func backButtonDidTap(_ sender: UIButton) {
        dismiss(animated: true)
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
        NotificationCenter.default.removeObserver(self, name: .inputDone, object: nil)
        NotificationCenter.default.removeObserver(self, name: .donateButtonDidTap, object: nil)
    }
}

//MARK:- Generate Description StackView

extension DonationDetailViewController {
    private func generateData(data: DonationDetail) {
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
    
    private func updateDetailImages(at imageView: UIImageView, image: UIImage?) {
        guard let image = image else { return }
        let imageRatio = image.size.height / image.size.width
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: descriptionStackView.frame.width * imageRatio).isActive = true
        imageView.image = image
    }

    private func configureDescriptionStackView(images: [String]) {
        descriptionImages = []
        images.forEach { generateDescriptionImages(imageURL: $0) }
        descriptionStackView.subviews.forEach { $0.removeFromSuperview() }
        descriptionImages.forEach {
            let imageView = UIImageView(image: $0)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            updateDetailImages(at: imageView, image: $0)
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


//MARK:- Fetch & Request

extension DonationDetailViewController {
    private func requestDonation(id: Int, point: String) {
        let request = DonateRequest(id: id)
        request.append(name: .ecoPoint, value: point)
        donationUseCase.getResources(request: request.asURLRequest(), dataType: DonationDetail.self) { result in
            switch result {
            case .success(let resultData):
                self.generateData(data: resultData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchMyEcoPoint() {
        let request = MyEcoPointRequest().asURLRequest()
        myEcoPointUseCase.getResources(request: request, dataType: MyEcoPoint.self) { result in
            switch result {
            case .success(let point):
                self.donateView.configureEcoPointLabel(point.ecoPoint)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchDonationDetailData(id: Int) {
        let request = DonationProjectDetailRequest(id: id).asURLRequest()
        donationProjectDetailUseCase.getResources(request: request, dataType: DonationDetail.self) { result in
            switch result {
            case .success(let donationDetail):
                self.donationDetail = donationDetail
                self.generateData(data: donationDetail)
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK:- Configurations

extension DonationDetailViewController {
    private func configure() {
        configureUI()
        configureUseCase()
        configureDonateView()
        configureObservers()
        configureToolbar()
    }
    
    private func configureUI() {
        donationButton.roundCorner(cornerRadius: 10)
    }
        
    private func configureUseCase() {
        donationProjectDetailUseCase = DonationProjectDetailUseCase()
        myEcoPointUseCase = MyEcoPointUseCase()
        donationUseCase = DonationUseCase()
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

    private func configureObservers() {
        configureKeyboardNotification()
        NotificationCenter.default.addObserver(self, selector: #selector(doneButtonDidTap(sender:)), name: .inputDone, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showAlert(_:)), name: .donateButtonDidTap, object: nil)
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

extension Notification.Name {
    static let inputDone = Notification.Name("inputDone")
    static let donateButtonDidTap = Notification.Name("donate")
}
