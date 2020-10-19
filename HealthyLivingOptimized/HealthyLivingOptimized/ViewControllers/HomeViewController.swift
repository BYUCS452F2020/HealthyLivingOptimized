//
//  HomeViewController.swift
//  HealthyLivingOptimized
//
//  Created by Robinson Paz Jesus on 9/25/20.
//  Copyright © 2020 Unagi Lab. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var topViewContainer: UIView!
    @IBOutlet weak var bottomViewContainer: UIView!
    @IBOutlet weak var recommendationLabel: UILabel!
    @IBOutlet weak var workoutTimeField: UITextField!
    @IBOutlet weak var sleepTimeField: UITextField!
    @IBOutlet weak var proteinsEatenField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind()
    }
    
    private func setupViews() {
        /// Nav Bar
        setCleanNavBar()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Assets.Image.arrowShareFill?.withTintColor(.white), style: .done, target: self, action: #selector(didTapProfile))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Assets.Image.tray, style: .done, target: self, action: #selector(didTapHistory))
        navigationController?.navigationBar.tintColor = .white
        
        topViewContainer.add(radius: 12, shadow: true)
        bottomViewContainer.add(radius: 12, shadow: true)
    }
    
    private func bind() {
        
    }
    
    // MARK: - Helper functions
    @IBAction func didTapSubmit(_ sender: Any) {
        print("Will submit")
        routeManager.performLogout()
    }
    
    static func createAreference() -> HomeViewController {
        
        let storyboard = UIStoryboard(name: "HomeViewController", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
            return controller
        } else {
            return HomeViewController()
        }
    }
    
    @objc func didTapProfile() {
        let profileViewController = ProfileViewController.createAreference()
        profileViewController.hidesBottomBarWhenPushed = true
        present(profileViewController, animated: true, completion:  nil)
    }
    
    @objc func didTapHistory() {
        let historyViewController = HistoryViewController.createAreference()
        historyViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(historyViewController, animated: true)
    }
}
