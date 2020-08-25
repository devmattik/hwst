//
//  PeriodViewController.swift
//  hwst
//
//  Created by Антон Прохоров on 21.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import UIKit

class PeriodViewController: UIViewController {

    private let periodsService = PeriodService()
    
    private let mainView = PeriodView()
    private lazy var tableView = mainView.tableView
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        periodsService.start()
        
        periodsService.onInserItems = { [weak self] indexes in
            guard let strongSelf = self else { return }
            let indexPaths = indexes.map({ IndexPath(row: $0, section: 0) })
            strongSelf.tableView.beginUpdates()
            strongSelf.tableView.insertRows(at: indexPaths, with: .none)
            strongSelf.tableView.endUpdates()
        }
    }
}

extension PeriodViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Периоды отключения горячей воды"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return periodsService.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: PeriodTableViewCell.identifier) as? PeriodTableViewCell,
            let item = periodsService.item(at: indexPath.row)
        else {
            return UITableViewCell()
        }
        
        cell.configure(with: item)
        return cell
    }
}

extension PeriodViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let actualPosition = scrollView.contentOffset.y;
        let contentHeight = scrollView.contentSize.height - (scrollView.frame.height * 2);
        if actualPosition >= contentHeight {
            periodsService.loadNextPage()
         }
    }
}
