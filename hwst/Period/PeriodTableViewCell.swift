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
    
    private let sideOffset: CGFloat = 8
    private let topAndBottomOffest: CGFloat = 4
    
    private let wrapperBottomOffest: CGFloat = 2
    
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
            wrapperView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            wrapperView.topAnchor.constraint(equalTo: contentView.topAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                constant: -wrapperBottomOffest),
            
            stackView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor,
                                               constant: sideOffset),
            stackView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor,
                                                constant: -sideOffset),
            stackView.topAnchor.constraint(equalTo: wrapperView.topAnchor,
                                           constant: topAndBottomOffest),
            stackView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor,
                                              constant: -topAndBottomOffest)
        ])
    }
    
    func configure(with model: PeriodViewModel ) {
        cityLabel.text = model.city
        streetLabel.text = model.address
        addressLabel.text = model.formattedHouse
        periodLabel.text = model.formattedPeriod
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
