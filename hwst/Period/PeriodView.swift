//
//  PeriodView.swift
//  hwst
//
//  Created by Антон Прохоров on 24.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import UIKit

class PeriodView: UIView {
    
    private let titleLabel = TitleLabel()
    
    let tableView = PeriodTableView()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .whiteLarge)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .darkGray
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    init() {
        super.init(frame: .zero)
        
        initUI()
        initLayout()
    }
    
    private func initUI() {
        backgroundColor = .white
        
        titleLabel.text = "Периоды отключения горячей воды"
        addSubview(titleLabel)
        addSubview(tableView)
        addSubview(spinner)
    }
    
    private func initLayout() {
        
        var titleTopConstraint: NSLayoutConstraint!
        if #available(iOS 11.0, *) {
            titleTopConstraint = titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16)
        } else {
            titleTopConstraint = titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 26)
        }
        
        NSLayoutConstraint.activate([
            titleTopConstraint,
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
