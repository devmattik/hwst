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
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private let cityLabel = TextLabel()
    private let streetLabel = TextLabel()
    private let addressLabel = TextLabel()
    private let periodLabel = TextLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initUI()
        initLayout()
    }
    
    private func initUI() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(streetLabel)
        stackView.addArrangedSubview(addressLabel)
        stackView.addArrangedSubview(periodLabel)
    }
    
    private func initLayout() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with model: PeriodAddressModel ) {
        cityLabel.text = model.city
        streetLabel.text = model.address
        addressLabel.text = model.formattedAddress()
        periodLabel.text = model.formettedPeriod()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
