//
//  BookCatalogueTableViewController.swift
//  BookCatalogue
//
//  Created by User on 18/01/2019.
//  Copyright © 2019 Fernandod. All rights reserved.
//

import UIKit

class BookCatalogueTableViewController: UITableViewController  {
    
    private let bookListViewModel = BookListViewModel()
    private var loadingIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareLoadingIndicator()
        bookListViewModel.delegate = self
        bookListViewModel.fetchBooks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func prepareLoadingIndicator() {
        let indicator = UIActivityIndicatorView(frame: self.view.bounds)
        indicator.style = .whiteLarge
        indicator.startAnimating()
        indicator.backgroundColor = UIColor(white: 0, alpha: 0.6)
        self.navigationController?.view.addSubview(indicator)
        self.loadingIndicator = indicator
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookListViewModel.numberOfItems(section)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as? BookTableViewCell {
            if let bookVM = bookListViewModel.modelAt(indexPath.row) {
                cell.configure(bookVM)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let bookModel = self.bookListViewModel.modelAt(indexPath.row) {
            if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookDetailViewController") as? BookDetailViewController {
                detailVC.viewModel = bookModel
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
            
        }
    }
    
}

extension BookCatalogueTableViewController: BookListViewModelDelegate {
    func didUpdateBookViewModels() {
        self.loadingIndicator?.removeFromSuperview()
        self.tableView.reloadData()
    }
}
