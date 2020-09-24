//
//  RouteManager.swift
//  HealthyLivingOptimized
//
//  Created by Robinson Paz Jesus on 8/4/20.
//  Copyright © 2020 Unagi Lab. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
}

class RouteManager {
    
    enum CoordinatorKeys {
        case start, home, authPage, login, signUp, forgottenPassword, sync
    }
    
    let window: UIWindow
    
    var isLoggedin = false //TODO: delete
    
    /// ViewControllers
    var mainTabBarController = MainViewController()
    
    
    init(window: UIWindow) {
        self.window = window
        window.makeKeyAndVisible()
        UINavigationBar.appearance().tintColor = Assets.Color.buttonTint
    }
}

extension RouteManager: Coordinator {
    
    func start() {
        
        if NetworkProxy.shared.getAuthToken() != nil {
            displayMain()
        } else {
            displayLogin()
        }
    }
    
    func displayMain() {
//        mainTabBarController.selectedIndex = 3
        replaceWindowRoot(with: mainTabBarController, animated: true)
    }
    
    func displayTest() {
        let test = CodeVerifyViewController.createAreference()
        let testNav = UINavigationController(rootViewController: test)
        replaceWindowRoot(with: testNav, animated: true)
    }
    
    func displayLogin() {
        let authenticateViewController = AuthenticateViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        replaceWindowRoot(with: authenticateViewController, animated: true)
    }
    
    func performLogout() {
        mainTabBarController.removeFromParent()
        mainTabBarController = MainViewController()
        displayLogin()
    }
}

extension RouteManager {
    
    private func replaceWindowRoot(with rootViewController: UIViewController, animated: Bool) {
        window.rootViewController = rootViewController
        UIView.transition(with: window, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseInOut], animations: nil, completion: nil)
    }
}
