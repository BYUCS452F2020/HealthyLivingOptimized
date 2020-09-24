//
//  UICollectionView+Ext.swift
//  HealthyLivingOptimized
//
//  Created by Robinson Paz Jesus on 8/12/20.
//  Copyright © 2020 Unagi Lab. All rights reserved.
//

import UIKit

extension UICollectionViewCell: AddIdentifier {}

extension UICollectionView {
    
    func register(_ classes: [AnyClass?]) {
        classes.forEach({ register($0, forCellWithReuseIdentifier: ($0 as! UICollectionViewCell.Type).identifier) })
    }
}

extension UICollectionView {
    
    func scrollToNearestVisibleCollectionViewCell() {
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.y + (self.bounds.size.height / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<self.visibleCells.count {
            let cell = self.visibleCells[i]
            let cellWidth = cell.bounds.size.height
            let cellCenter = Float(cell.frame.origin.y + cellWidth / 2)

            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            self.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredVertically, animated: true)
        }
    }
}


