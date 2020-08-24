//
//  TextLabel.swift
//  hwst
//
//  Created by Антон Прохоров on 24.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import UIKit

class TextLabel: UILabel {
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
