//
//  ContactsViewController.swift
//  contacts
//
//  Created by Денис Матвеев on 26.02.2022.
//  Copyright © 2022 SkbkonturMobile. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {

    static let nibName = "ContactsViewController"
    
    weak var vc: ContactsViewController?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorView: UIViewAttExtension!
    @IBOutlet weak var errorViewTextLabel: UILabel!
    
    let searchController = UISearchController()
    
    var interactor: ContactsInteractorProtocol!
    
    let progressBar = Bundle.main.loadNibNamed("ProgressBar", owner: nil, options: nil)?.first as! ProgressBarView
    
    private var configurator = ContactsConfigurator()
    private var cellIdentifiers: [String] = [
        String(describing: ContactTableViewCell.self)
    ]
    
    private var viewModel: ContactsViewModel.ViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        vc = self
        configurator.configure(view: self)
        searchBarSetup()
        setupTableView()
        interactor.loadData()
    }
    
    private func searchBarSetup() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCells(cellIdentifiers)
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    @objc func didPullToRefresh() {
        searchController.searchBar.text?.removeAll()
        interactor.loadData()
        tableView.refreshControl?.endRefreshing()
    }
    
}

//MARK: UISearchResultsUpdating

extension ContactsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text ?? ""
        interactor.search(text: text)
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate

extension ContactsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.contactCellViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return contactCell(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.routeToSelectedContact(index: indexPath.row)
    }
    
}

// MARK: Cell Creating

extension ContactsViewController {
    
    private func contactCell(indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel?.contactCellViewModels[indexPath.row] else {return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContactTableViewCell.self), for: indexPath) as! ContactTableViewCell
        cell.viewModel = viewModel
        return cell
    }
     
}

// MARK: ContactsViewProtocol

extension ContactsViewController: ContactsViewProtocol {
    func displayInfo(viewModel: ContactsViewModel.ViewModel) {
        self.viewModel = viewModel
    }
    
    func displayError(error: String) {
        errorViewTextLabel.text = error
        errorView.alpha = 0
        errorView.isHidden = false
        UIView.animate(withDuration: 0.4, animations: { [weak self] in
            self?.errorView.alpha = 1
        }) { [weak self] _ in
            UIView.animate(withDuration: 5, animations: {
                self?.errorView.alpha = 0
            }) { (finished) in
                self?.errorView.isHidden = finished
            }
        }
        
    }
    
    func showProgress() {
        progressBar.show(self)
    }
    
    func hideProgress() {
        progressBar.dismiss()
    }
    
    func updateView() {
        tableView.reloadData()
    }
    
}
