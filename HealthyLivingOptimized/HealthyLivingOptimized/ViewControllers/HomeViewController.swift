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
    
    let fetcher = FetcherController()
    
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
    
    func getDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: Date())
        formatter.dateFormat = "MM"
        let month = formatter.string(from: Date())
        formatter.dateFormat = "dd"
        let day = formatter.string(from: Date())
        return "\(year)-\(month)-\(day)"
    }
    
    
    // MARK: - Helper functions
    @IBAction func didTapSubmit(_ sender: Any) {
        let email = NetworkProxy.shared.getEmail()!
        let dateString = getDateString()
        
        let minutesOfExercise = workoutTimeField.text!
        let hoursOfSleep = sleepTimeField.text!
        let gramsOfProtein = proteinsEatenField.text!
        
        let typeOfExercise = "Strength Training"
        let currentWeight = "150"
        let mood = "Happy"
        let muscleGrowth = "Yes"
        
        let body: [String: String] = [
            "email": email,
            "date": dateString,
            "hoursOfSleep": hoursOfSleep,
            "gramsOfProtein": gramsOfProtein,
            "typeOfExercise": typeOfExercise,
            "minutesOfExercise": minutesOfExercise,
            "currentWeight": currentWeight,
            "mood": mood,
            "muscleGrowth": muscleGrowth
        ]
        
        
        let loader = animateLoader()
        
        fetcher.postEntry(body: body)
            .done { successResponse in
                if successResponse.success == "true" {
                    print("Succeeded")
                    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                    self.presentSheet(message: "SUCCESS!", actions: [ok], preferredStyle: .alert)
                } else {
                    print("Failed")
                }
            }.catch{ log.error($0) }
            .finally {
                /// Clear all
                self.workoutTimeField.text = ""
                self.sleepTimeField.text = ""
                self.proteinsEatenField.text = ""
                
                /// Restore view
                loader.stopAnimating()
                self.view.resignFirstResponder()
            }
        
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
