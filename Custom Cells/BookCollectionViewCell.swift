//
//  BookCollectionViewCell.swift
//  BookCatalogue
//
//  Created by User on 18/01/2019.
//  Copyright © 2019 Fernandod. All rights reserved.
//

import Foundation
import UIKit

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var bookImageView: LazyLoadingImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    
    func configure(_ viewModel: BookViewModel) {
        self.bookTitleLabel.text = viewModel.title
        self.bookAuthorLabel.text = viewModel.author
        if let imageLocation = viewModel.imageLocation {
            self.bookImageView.loadImageFromURLString(imageLocation)
        }
        
    }
}
