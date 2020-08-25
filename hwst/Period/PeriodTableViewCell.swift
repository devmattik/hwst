//
//  PeriodTableViewCell.swift
//  hwst
//
//  Created by Антон Прохоров on 24.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import UIKit

class PeriodTableViewCell: UITableViewCell {
    static let identifier = "PeriodTableViewCell"
    
    private let stackView = PeriodStackView()
    private let cityLabel = TextLabel()
    private let streetLabel = TextLabel()
    private let addressLabel = TextLabel()
    private let periodLabel = TextLabel()
    
    private let offset: CGFloat = 16
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initUI()
        initLayout()
    }
    
    private func initUI() {
        backgroundColor = .clear
        selectionStyle = .none
    
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(streetLabel)
        stackView.addArrangedSubview(addressLabel)
        stackView.addArrangedSubview(periodLabel)
        
        contentView.addSubview(stackView)
    }
    
    private func initLayout() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: offset),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -offset),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: offset),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -offset)
        ])
    }
    
    func configure(with model: PeriodAddressModel ) {
        cityLabel.text = model.city
        streetLabel.text = model.formattedAddress()
        addressLabel.text = model.formattedHouse()
        periodLabel.text = model.formattedPeriod()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
