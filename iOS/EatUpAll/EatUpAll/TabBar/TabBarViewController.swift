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
    
    private var homeViewController: UIViewController!
    private var donationViewController: UIViewController!
    private var challengeFeedViewController: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
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
    }
    
    private func configureTabBar() {
        tabBar.tintColor = UIColor(named: "key_green")
    }
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    private func configureChildViewControllers() {
        homeViewController = HomeViewController.loadFromNib()
        donationViewController = DonationViewController.loadFromNib()
        let doChallengeViewController = UIViewController()
        challengeFeedViewController = ChallengeViewController.loadFromNib()
        let myPageViewController = UIViewController()
        
        let donationNavigationController = UINavigationController(rootViewController: donationViewController)
        let challengeNavigationController = UINavigationController(rootViewController: challengeFeedViewController)
        
        viewControllers = [
            homeViewController,
            donationNavigationController,
            doChallengeViewController,
            challengeNavigationController,
            myPageViewController
        ]
    }
    
    private func configureTabBarItems() {
        homeViewController.title = "홈"
        donationViewController.title = "기부"
        challengeFeedViewController.title = "챌린지"
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
