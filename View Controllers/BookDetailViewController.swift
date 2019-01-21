//
//  BookDetailViewController.swift
//  BookCatalogue
//
//  Created by User on 18/01/2019.
//  Copyright © 2019 Fernandod. All rights reserved.
//

import Foundation
import UIKit

class BookDetailViewController: UIViewController {
    @IBOutlet weak var bookCoverImageView: LazyLoadingImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    var viewModel: BookViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.bookTitleLabel.text = viewModel?.title
        self.bookAuthorLabel.text = viewModel?.author
        if let imageLocation = viewModel?.imageLocation {
            self.bookCoverImageView.loadImageFromURLString(imageLocation)
        }
    }
}
