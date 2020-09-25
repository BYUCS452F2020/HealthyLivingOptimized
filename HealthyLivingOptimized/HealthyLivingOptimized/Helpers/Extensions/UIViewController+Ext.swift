//
//  UIViewController+Ext.swift
//  HealthyLivingOptimized
//
//  Created by Robinson Paz Jesus on 8/3/20.
//  Copyright © 2020 Unagi Lab. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

extension UIViewController: AddIdentifier {}

extension UIViewController {
    
    @objc func handleDismiss() {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func setNoBackText() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func setCleanNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .clear
        navigationItem.largeTitleDisplayMode = .never
    }
}

extension UIViewController {
    
    func presentSheet(message: String? = nil, actions: [UIAlertAction], preferredStyle: UIAlertController.Style = .actionSheet) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: preferredStyle)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        for action in actions {
            alert.addAction(action)
        }
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func presentError(title: String? = "Oops!",
                             message: String? = "There has been an error, please try again later.") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}

extension UIViewController {
    
    func animateLoader() -> NVActivityIndicatorView {
        let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80),
                                                            type: .ballScaleRippleMultiple,
                                                            color: .label)
        view.addSubview(activityIndicatorView)
        activityIndicatorView.anchorCenterSuperview()
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }
}

