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
        
        startSpinner()
        
        periodsService.onInserItems = { [weak self] indexes in
            guard let strongSelf = self else { return }
            let indexPaths = indexes.map({ IndexPath(row: $0, section: 0) })
            UIView.performWithoutAnimation {
                strongSelf.tableView.insertRows(at: indexPaths, with: .none)
            }
            strongSelf.stopSpinner()
        }
        
        periodsService.onReloadAllItems = { [weak self] in
            self?.tableView.reloadData()
        }
        
        periodsService.onError = { [weak self] errorMessage in
            self?.showError(message: errorMessage)
            self?.stopSpinner()
        }
    }
    
    private func startSpinner() {
        mainView.spinner.startAnimating()
    }
    
    private func stopSpinner() {
        mainView.spinner.stopAnimating()
    }
    
    private func showError(message: String) {
        let alert = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        let retryAction = UIAlertAction(title: "Повторить", style: .default, handler: { [weak self] _ in
            self?.startSpinner()
            self?.periodsService.reStart()
        })
        
        alert.addAction(cancelAction)
        alert.addAction(retryAction)
        
        present(alert, animated: true, completion: nil)
    }
}

extension PeriodViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 4
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
