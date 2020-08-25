//
//  PeriodView.swift
//  hwst
//
//  Created by Антон Прохоров on 24.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import UIKit

class PeriodView: UIView {
    let tableView = PeriodTableView()
    
    init() {
        super.init(frame: .zero)
        
        initUI()
        initLayout()
    }
    
    private func initUI() {
        backgroundColor = .white
        addSubview(tableView)
    }
    
    private func initLayout() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
