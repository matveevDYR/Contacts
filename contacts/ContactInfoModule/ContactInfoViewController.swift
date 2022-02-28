//
//  ContactInfoViewController.swift
//  ContactInfo
//
//  Created by Денис Матвеев on 26.02.2022.
//  Copyright © 2022 SkbkonturMobile. All rights reserved.
//

import UIKit

class ContactInfoViewController: UIViewController {
    
    static let nibName = "ContactInfoViewController"
    
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: ContactInfoInteractorProtocol!
    
    private var cellIdentifiers: [String] = [
        String(describing: ContactHeaderTableViewCell.self),
        String(describing: ContactPhoneTableViewCell.self),
        String(describing: ContactBiographyTableViewCell.self)
    ]
    
    private var viewModel: ContactInfoViewModel.ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        interactor.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCells(cellIdentifiers)
    }
    
}

// MARK: UITableViewDataSource, UITableViewDelegate

extension ContactInfoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0: return contactHeaderCell(indexPath: indexPath)
        case 1: return contactPhoneCell(indexPath: indexPath)
        case 2: return contactBiographyCell(indexPath: indexPath)
        default: return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

// MARK: Cell Creating

extension ContactInfoViewController {
    
    private func contactHeaderCell(indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel?.contactHeaderCellViewModel else {return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContactHeaderTableViewCell.self), for: indexPath) as! ContactHeaderTableViewCell
        cell.viewModel = viewModel
        return cell
    }
    
    private func contactPhoneCell(indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel?.contactPhoneCellViewModel else {return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContactPhoneTableViewCell.self), for: indexPath) as! ContactPhoneTableViewCell
        cell.viewModel = viewModel
        return cell
    }
    
    private func contactBiographyCell(indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel?.contactBiographyCellViewModel else {return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContactBiographyTableViewCell.self), for: indexPath) as! ContactBiographyTableViewCell
        cell.viewModel = viewModel
        return cell
    }
    
}

// MARK: ContactInfoViewProtocol

extension ContactInfoViewController: ContactInfoViewProtocol {
    func displayInfo(viewModel: ContactInfoViewModel.ViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
    
}
