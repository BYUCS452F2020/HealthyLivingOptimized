//
//  TableView+Ext.swift
//  Tweets
//
//  Created by Robinson Paz Jesus on 9/26/19.
//  Copyright © 2019 Robinson Paz Jesus. All rights reserved.
//

import UIKit

extension UITableView {
    
    static func getDefaultTable(container: UIView?,
                                style: UITableView.Style = .grouped,
                                padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) -> UITableView {
        let tableView = UITableView(frame: .zero, style: style)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 32, right: 0)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = Assets.Color.pages
        if let container = container {
            container.addSubview(tableView)
            tableView.fillSuperview(padding: padding)
        }
        return tableView
    }
}


