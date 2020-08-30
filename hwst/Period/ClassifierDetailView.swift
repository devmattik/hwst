//
//  ClassifierDetailView.swift
//  hwst
//
//  Created by Антон Прохоров on 24.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import UIKit

class ClassifierDetailView: UIView {
    
    let tableView = PeriodTableView()
    let spinner = SpinnerView()
    
    init() {
        super.init(frame: .zero)
        
        initUI()
        initLayout()
    }
    
    private func initUI() {
        backgroundColor = .white
                
        addSubview(tableView)
        addSubview(spinner)
    }
    
    private func initLayout() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
