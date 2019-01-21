//
//  BookViewModel.swift
//  BookCatalogue
//
//  Created by User on 18/01/2019.
//  Copyright © 2019 Fernandod. All rights reserved.
//

import Foundation

protocol BookListViewModelDelegate {
    func didUpdateBookViewModels()
}

class BookListViewModel {
    private var bookViewModels = [BookViewModel]()
    var delegate: BookListViewModelDelegate?
    
    func numberOfItems(_ section: Int) -> Int {
        return bookViewModels.count
    }
    
    func modelAt(_ index: Int) -> BookViewModel? {
        if (index < bookViewModels.count) {
            return bookViewModels[index]
        }
        
        return nil
    }
    
    func fetchBooks() {
        if let booksURL = URL(string:"https://de-coding-test.s3.amazonaws.com/books.json") {
            let bookResource = Resource<[BookViewModel]>(url: booksURL) { data in
                let bookViewModel = try? JSONDecoder().decode([BookViewModel].self, from: data)
                return bookViewModel
            }
            
            Webservice().load(resource: bookResource) { [weak self] result in
                if let bookVM = result {
                    self?.bookViewModels = bookVM
                    self?.delegate?.didUpdateBookViewModels()
                }
            }
        }
    }
}

struct BookViewModel: Decodable {
    let title: String?
    let author: String?
    let imageLocation: String?
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case author = "author"
        case imageLocation = "imageURL"
    }
}
