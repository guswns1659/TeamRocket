//
//  TabBarViewController.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/13.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    private enum Image {
        static let home: UIImage? = UIImage(named: "home")
        static let donation: UIImage? = UIImage(named: "donation")
        static let challenge: UIImage? = UIImage(named: "challenge")
        static let challengeFeed: UIImage? = UIImage(named: "challenge-feed")
        static let myPage: UIImage? = UIImage(named: "user")
    }
    
    private enum Color {
        static let keyGreen: UIColor = UIColor(named: "key_green")!
    }
    
    private var homeViewController: UIViewController!
    private var donationViewController: UIViewController!
    private var challengeCameraNavigationController: UINavigationController!
    private var challengeCameraViewController: ChallengeCameraViewController!
    private var challengeFeedViewController: UIViewController!
    private var myPageViewController: UIViewController!
    private var challengeButton: UIButton!
    
    private var challengePointPopUpViewController: ChallengePointViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: .didScanChallengeQRCode,
            object: nil)
    }
}

// MARK:- ChallengeCameraViewControllerDelegate

extension TabBarViewController: ChallengeCameraViewControllerDelegate {
    func didSuccessToUploadChallenge(mode: ChallengeCameraViewController.Mode) {
        challengePointPopUpViewController.modalPresentationStyle = .overFullScreen
        present(challengePointPopUpViewController, animated: true, completion: nil)
        challengePointPopUpViewController.configureEcoPoints(with: mode)
    }
}

// MARK:- QR Code Notification

extension TabBarViewController {
    @objc private func DidScanChallengeQRCode(notification: Notification) {
        guard let restaurantId = notification.userInfo?["restaurantID"] as? Int else { return }
        challengeCameraNavigationController.modalPresentationStyle = .fullScreen
        present(challengeCameraNavigationController, animated: true, completion: nil)
        challengeCameraViewController.configureMode(to: .QRMode)
        challengeCameraViewController.configureRestaurantID(restaurantId)
        challengeCameraViewController.delegate = self
    }
}

// MARK:- Configuration

extension TabBarViewController {
    private func configure() {
        configureUI()
        configureChildViewControllers()
        configureTabBar()
        configureTabBarItems()
        configureTabBarImages()
        configureChallengeButton()
        configureChallengeButtonAction()
        configureQRCodeNotification()
    }
    
    private func configureQRCodeNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(DidScanChallengeQRCode),
            name: .didScanChallengeQRCode,
            object: nil)
    }
    
    private func configureChallengeButtonAction() {
        challengeButton.addTarget(self, action: #selector(challengeButtonDidTap), for: .touchUpInside)
    }
    
    @objc private func challengeButtonDidTap() {
        animateChallengeButton()
    }
    
    private func presentCameraController() {
        challengeCameraNavigationController.modalPresentationStyle = .fullScreen
        present(challengeCameraNavigationController, animated: true, completion: nil)
        challengeCameraViewController.configureMode(to: .challengeMode)
        challengeCameraViewController.configureRestaurantID(nil)
        challengeCameraViewController.delegate = self
    }
    
    private func animateChallengeButton() {
        let tabChallenge = tabBar.items![2]
        tabChallenge.image = tabChallenge.image?.withTintColor(
            Color.keyGreen, renderingMode: .alwaysOriginal)
        tabChallenge.title = "인증"
        
        UIView.animateCurveEaseOut(
            withDuration: 0.2,
            animations: {
                self.view.alpha = 0.99
        }) { (_) in
            self.view.alpha = 1
            tabChallenge.image = Image.challenge
            self.presentCameraController()
        }
    }
    
    private func configureChallengeButton() {
        challengeButton = UIButton(type: .system)
        challengeButton.backgroundColor = .clear
        
        let numberOfItems = CGFloat(tabBar.items!.count)
        let tabBarItemSize = CGSize(
            width: tabBar.frame.width / numberOfItems,
            height: tabBar.frame.height)
        challengeButton.frame = CGRect(
            x: 0,
            y: 0,
            width: tabBarItemSize.width,
            height: tabBarItemSize.height)
        var buttonFrame = challengeButton.frame
        buttonFrame.origin.y = view.bounds.height - buttonFrame.height - view.safeAreaInsets.bottom
        buttonFrame.origin.x = view.bounds.width / 2 - buttonFrame.width / 2
        challengeButton.frame = buttonFrame
        view.addSubview(challengeButton)
        view.layoutIfNeeded()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        challengeButton.frame.origin.y = view.bounds.height - challengeButton.frame.height - view.safeAreaInsets.bottom
    }
    
    private func configureTabBar() {
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor(named: "key_green")
    }
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    private func configureChildViewControllers() {
        homeViewController = HomeViewController.loadFromNib()
        donationViewController = DonationViewController.loadFromNib()
        challengeCameraViewController = ChallengeCameraViewController.loadFromNib()
        challengeCameraNavigationController = UINavigationController(rootViewController: challengeCameraViewController)
        let dummyChallengeCameraViewController = UIViewController()
        challengeFeedViewController = ChallengeFeedViewController.loadFromNib()
        myPageViewController = MyPageViewController.loadFromNib()
        
        let donationNavigationController = UINavigationController(rootViewController: donationViewController)
        let challengeNavigationController = UINavigationController(rootViewController: challengeFeedViewController)
        
        challengePointPopUpViewController = ChallengePointViewController.loadFromNib()
        
        viewControllers = [
            homeViewController,
            donationNavigationController,
            dummyChallengeCameraViewController,
            challengeNavigationController,
            myPageViewController
        ]
    }
    
    private func configureTabBarItems() {
        homeViewController.title = "홈"
        donationViewController.title = "기부"
        let tabChallenge = tabBar.items![2]
        tabChallenge.title = "인증"
        challengeFeedViewController.title = "챌린지"
        myPageViewController.title = "내 정보"
    }
    
    private func configureTabBarImages() {
        let tabHome = tabBar.items![0]
        tabHome.image = Image.home
        let tabDonation = tabBar.items![1]
        tabDonation.image = Image.donation
        let tabChallenge = tabBar.items![2]
        tabChallenge.image = Image.challenge
        let tabChallengeFeed = tabBar.items![3]
        tabChallengeFeed.image = Image.challengeFeed
        let tabMyPage = tabBar.items![4]
        tabMyPage.image = Image.myPage
    }
}
