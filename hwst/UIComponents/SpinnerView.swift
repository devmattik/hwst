//
//  SpinnerView.swift
//  hwst
//
//  Created by Антон Прохоров on 26.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import UIKit

class SpinnerView: UIActivityIndicatorView {
    init() {
        super.init(style: .whiteLarge)
        translatesAutoresizingMaskIntoConstraints = false
        color = .darkGray
        hidesWhenStopped = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
