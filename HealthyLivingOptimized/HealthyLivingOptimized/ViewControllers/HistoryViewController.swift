//
//  HistoryViewController.swift
//  HealthyLivingOptimized
//
//  Created by Robinson Paz Jesus on 10/19/20.
//  Copyright © 2020 Unagi Lab. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    // MARK: - Properties
    let fetcherController = FetcherController()
    
    // MARK: - UI Properties
    var collectionView: UICollectionView!
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind()
        load()
    }
    
    private func setupViews() {
        
        // collection view
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 350, height: 150)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = false
        collectionView.register(HistoryCell.self, forCellWithReuseIdentifier: HistoryCell.identifier)
        view.addSubview(collectionView)
        collectionView.fillSuperview(padding: UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0))
    }
    
    private func bind() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func load() {
        fetcherController.getHistory()
            .done { entries in
                print("Done")
                
        }.catch { log.error($0) }
    }
    
    // MARK: - Helper functions
    static func createAreference() -> HistoryViewController {
        
        let storyboard = UIStoryboard(name: "HomeViewController", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "HistoryViewController") as? HistoryViewController {
            return controller
        } else {
            return HistoryViewController()
        }
    }
}

extension HistoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCell.identifier, for: indexPath) as! HistoryCell
        cell.configure(title: "September 20, 2020", body: "1. 30 mins wo\n2. 8 hrs sleep\n3. 100g in protein")
        return cell
    }
    
    
}
