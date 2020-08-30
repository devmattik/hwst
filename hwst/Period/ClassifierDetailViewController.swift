//
//  ClassifierDetailViewController.swift
//  hwst
//
//  Created by Антон Прохоров on 21.08.2020.
//  Copyright © 2020 Anton Prokhorov. All rights reserved.
//

import UIKit

class ClassifierDetailViewController: UIViewController {
    
    private let viewModel: ClassifierDetailViewModel
    private let mainView = ClassifierDetailView()
    private lazy var tableView = mainView.tableView
    
    init(viewModel: ClassifierDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = GlobalStrings.periodTitle
        tableView.dataSource = self
        tableView.delegate = self
        
        start()
        
        viewModel.onInserItems = { [weak self] indexPaths in
            guard let strongSelf = self else { return }
            strongSelf.stopSpinner()
            UIView.performWithoutAnimation {
                strongSelf.tableView.insertRows(at: indexPaths, with: .none)
            }
        }
        
        viewModel.onReloadAllItems = { [weak self] in
            self?.stopSpinner()
            self?.tableView.reloadData()
        }
        
        viewModel.onError = { [weak self] errorMessage in
            self?.showError(message: errorMessage)
            self?.stopSpinner()
        }
    }
    
    private func start() {
        startSpinner()
        viewModel.start()
    }
    
    private func startSpinner() {
        mainView.spinner.startAnimating()
    }
    
    private func stopSpinner() {
        mainView.spinner.stopAnimating()
    }
    
    private func showError(message: String) {
        let alert = UIAlertController(title: GlobalStrings.errorTitle, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: GlobalStrings.cancel, style: .destructive, handler: nil)
        
        let retryAction = UIAlertAction(title: GlobalStrings.retry, style: .default, handler: { [weak self] _ in
            self?.start()
        })
        
        alert.addAction(cancelAction)
        alert.addAction(retryAction)
        
        present(alert, animated: true, completion: nil)
    }
}

extension ClassifierDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: PeriodTableViewCell.identifier) as? PeriodTableViewCell,
            let item = viewModel.item(at: indexPath.row)
        else {
            return UITableViewCell()
        }
        
        cell.configure(with: item)
        return cell
    }
}

extension ClassifierDetailViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let actualPosition = scrollView.contentOffset.y;
        let contentHeight = scrollView.contentSize.height - (scrollView.frame.height * 2);
        if actualPosition >= contentHeight {
            viewModel.loadNextPage()
         }
    }
}
