//
//  MainViewController.swift
//  HealthyLivingOptimized
//
//  Created by Robinson Paz Jesus on 9/24/20.
//  Copyright © 2020 Unagi Lab. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    // MARK: - Properties
    
    // MARK: - UI Properties
    let homeViewController = HomeViewController.createAreference()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind()
    }
    
    private func setupViews() {
        view.backgroundColor = .green
        let homeNav = UINavigationController(rootViewController: homeViewController)
        homeViewController.tabBarItem.image =  Assets.Image.personFill
        viewControllers = [homeNav]
    }
    
    private func bind() {
        
    }
    
    // MARK: - Helper functions
}
