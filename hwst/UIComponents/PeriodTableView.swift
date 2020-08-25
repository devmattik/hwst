//
//  PeriodTableView.swift
//  hwst
//
//  Created by Антон Прохоров on 25.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import UIKit

class PeriodTableView: UITableView {
    init() {
        super.init(frame: .zero, style: .grouped)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .lightGray
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 140
        separatorStyle = .none
        sectionHeaderHeight = 4
        register(PeriodTableViewCell.self, forCellReuseIdentifier: PeriodTableViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
