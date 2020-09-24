//
//  AuthenticateViewController.swift
//  HealthyLivingOptimized
//
//  Created by Robinson Paz Jesus on 9/24/20.
//  Copyright © 2020 Robinson Paz Jesus. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static let authenticate = UIStoryboard(name: "Authenticate", bundle: nil)
}

class AuthenticateViewController: UIPageViewController {
    
    var subViewControllers : [UIViewController] = [
        UIStoryboard.authenticate.instantiateViewController(identifier: GetStartedViewController.identifier),
        UIStoryboard.authenticate.instantiateViewController(identifier: SignInViewController.identifier)
    ]
    
    var getStartedViewController: UIViewController {
        return subViewControllers[0]
    }
    
    var signInViewController: UIViewController {
        return subViewControllers[1]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        setViewControllers([subViewControllers[0]], direction: .forward, animated: true, completion: nil)
        
        let backgroundImage = UIImageView(image: Assets.Image.background)
        backgroundImage.alpha = 0.5
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
        backgroundImage.fillSuperview()
        
        /// Logo
        let logoLabel = setTitleLogoView()
        view.addSubview(logoLabel)
        logoLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, tCons: 32, lCons: 16)
    }
    
    func setTitleLogoView() -> UIView {
        
        let attributedString = NSAttributedString(string: "Healthy Living", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 40),
            .foregroundColor: UIColor.white,
            .kern: -2.4
        ])
        let titleLabel = UILabel()
        titleLabel.attributedText =  attributedString
        let subtitleLabel = UILabel()
        subtitleLabel.text = "OPTIMIZED"
        subtitleLabel.font = UIFont.systemFont(ofSize: 18)
        subtitleLabel.textColor = .white
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        return stackView
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension AuthenticateViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = subViewControllers.firstIndex(of: viewController) ?? 0
        if currentIndex <= 0 {
            return nil
        } else {
            return subViewControllers[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = subViewControllers.firstIndex(of: viewController) ?? 0
        if currentIndex >= subViewControllers.count - 1 {
            return nil
        } else {
            return subViewControllers[currentIndex + 1]
        }
    }
}
