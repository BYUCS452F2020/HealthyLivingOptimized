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
    var entries: [EntryHistoryModel]?
    
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
        /// nav
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Assets.Image.close, style: .done, target: self, action: #selector(didTapLogout))
        
        // collection view
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 350, height: 150)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        collectionView.register(HistoryCell.self, forCellWithReuseIdentifier: HistoryCell.identifier)
        view.addSubview(collectionView)
        collectionView.fillSuperview()
    }
    
    @objc func didTapLogout() {
        routeManager.performLogout()
    }
    
    private func bind() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func load() {
        fetcherController.getHistory()
            .done { entries in
                self.reloadData(entries: entries)
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
    
    func reloadData(entries: [EntryHistoryModel]) {
        self.entries = entries
        collectionView.reloadData()
    }
}

extension HistoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entries?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCell.identifier, for: indexPath) as! HistoryCell
        cell.configure(model: entries![indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let entry = self.entries?[indexPath.item] else { return }
        print("DELETING: ", entry)
        let id = entry.entryId
        let loader = animateLoader()
        let email = NetworkProxy.shared.getEmail()!
        fetcherController.deleteEntry(with: id, for: email)
            .done { _ in
                self.entries?.remove(at: indexPath.row)
                self.collectionView.deleteItems(at: [indexPath])
            }.catch({
                log.error($0)
                self.entries?.remove(at: indexPath.row)
                self.collectionView.deleteItems(at: [indexPath])
                
            })
            .finally {
                loader.stopAnimating()
            }
    }
    
}
