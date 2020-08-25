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
    
    private let wrapperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let offset: CGFloat = 8
    
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
        
        wrapperView.addSubview(stackView)
        contentView.addSubview(wrapperView)
    }
    
    private func initLayout() {
        NSLayoutConstraint.activate([
            wrapperView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            wrapperView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            wrapperView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            wrapperView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -offset/2),
            
            stackView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: offset),
            stackView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: offset),
            stackView.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: offset/2),
            stackView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -offset/2)
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
