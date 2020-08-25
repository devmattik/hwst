//
//  TitleLabel.swift
//  hwst
//
//  Created by Антон Прохоров on 26.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import UIKit

class TitleLabel: UILabel {
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .black
        font = UIFont.systemFont(ofSize: 17)
        textAlignment = .center
        numberOfLines = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
