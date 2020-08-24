//
//  ViewController.swift
//  hwst
//
//  Created by Антон Прохоров on 21.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let clasifierService = ClassifierService()
    private let periodsService = PeriodsService()
    
    let mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(PeriodTableViewCell.self, forCellReuseIdentifier: PeriodTableViewCell.identifier)
        return tableView
    }()
    
    override func loadView() {
        view = mainTableView
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clasifierService.load() { [weak self] result in
            switch result {
            case .success(let url):
                self?.periodsService.load(url: url)
            case .failure(let error):
                debugPrint(error)
            }
        }
        
        periodsService.onUpdatePeriods = { [weak self] indexes in
            let indexPaths = indexes.map({ IndexPath(row: $0, section: 0) })
            self?.mainTableView.beginUpdates()
            self?.mainTableView.insertRows(at: indexPaths, with: .automatic)
            self?.mainTableView.endUpdates()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return periodsService.periodAddresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: PeriodTableViewCell.identifier) as? PeriodTableViewCell
        else {
            return UITableViewCell()
        }
        
        let item = periodsService.periodAddresses[indexPath.row]
        cell.configure(with: item)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let actualPosition = scrollView.contentOffset.y;
        let contentHeight = scrollView.contentSize.height - (UIScreen.main.bounds.height * 2);
        if (actualPosition >= contentHeight) {
            periodsService.loadPage()
         }
    }
}


