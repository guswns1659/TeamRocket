//
//  SceneDelegate.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/13.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = TabBarViewController()
        window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            let urlStr = url.absoluteString
            let component = urlStr.components(separatedBy: "=")
            if component.count > 1, let restaurantID = component.last {
                postNotification(userInfo: ["restaurantID": Int(restaurantID) as Any])
            }
        }
    }
    
    private func postNotification(userInfo: [String: Any]) {
        print(userInfo["restaurantID"] as! Int)
    }
}
