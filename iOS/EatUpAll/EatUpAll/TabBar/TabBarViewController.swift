//
//  TabBarViewController.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/13.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    private var homeViewController: UIViewController!
    private var donationViewController: UIViewController!

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
        configureTabBarItems()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    private func configureChildViewControllers() {
        homeViewController = HomeViewController.loadFromNib()
        donationViewController = DonationViewController.loadFromNib()
        let donationNavigationController = UINavigationController(rootViewController: donationViewController)
        viewControllers = [homeViewController, donationNavigationController]
    }
    
    private func configureTabBarItems() {
        homeViewController.title = "홈"
        donationViewController.title = "기부"
    }
}
