//
//  LazyLoadingImageView.swift
//  BookCatalogue
//
//  Created by User on 18/01/2019.
//  Copyright © 2019 Fernandod. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

class LazyLoadingImageView: UIImageView {
    
    private var imageURLString: String?
    private var loadingIndicator: UIActivityIndicatorView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareLoadingIndicator()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareLoadingIndicator()
    }
    
    private func prepareLoadingIndicator() {
        let indicator = UIActivityIndicatorView(frame: self.bounds)
        indicator.style = .gray
        indicator.startAnimating()
        self.addSubview(indicator)
        self.loadingIndicator = indicator
    }
    
    func loadImageFromURLString(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        imageURLString = urlString
        self.image = nil
        self.loadingIndicator?.startAnimating()
        self.loadingIndicator?.isHidden = false
        if let cachedImage = imageCache.object(forKey: NSString(string: url.absoluteString)) {
            self.image = cachedImage
            self.loadingIndicator?.stopAnimating()
            self.loadingIndicator?.isHidden = true
            return
        }
        
        let imageResource = Resource<UIImage>(url: url) { data in
            if let image = UIImage(data: data) {
                return image
            }
            
            return UIImage()
        }

        Webservice().load(resource: imageResource) { [weak self] result in
            if let image = result {
                self?.loadingIndicator?.stopAnimating()
                self?.loadingIndicator?.isHidden = true
                imageCache.setObject(image, forKey: NSString(string: url.absoluteString))
                if (self?.imageURLString == url.absoluteString) {
                    self?.image = image
                }
            }
        }
    }
    
}
