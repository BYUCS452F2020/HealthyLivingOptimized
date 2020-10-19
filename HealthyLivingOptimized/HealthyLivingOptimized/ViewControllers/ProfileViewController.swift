//
//  ProfileViewController.swift
//  HealthyLivingOptimized
//
//  Created by Robinson Paz Jesus on 10/19/20.
//  Copyright © 2020 Unagi Lab. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    // MARK: - Properties
    let fetcher = FetcherController()
    
    // MARK: - UI Properties
    
    @IBOutlet weak var topBackView: UIView!
    @IBOutlet weak var bottomBackView: UIView!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind()
        load()
    }
    
    private func setupViews() {
        title = "Profile"
        topBackView.add(radius: 16, shadow: true)
        bottomBackView.add(radius: 16, shadow: true)
    }
    
    private func bind() {
        
    }
    
    private func load() {
        fetcher.getProfile()
            .done { profileModel in
                print("Done! ", profileModel)
        }.catch { log.error($0) }
    }
    
    // MARK: - Helper functions
    static func createAreference() -> ProfileViewController {
        
        let storyboard = UIStoryboard(name: "HomeViewController", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController {
            return controller
        } else {
            return ProfileViewController()
        }
    }
}
