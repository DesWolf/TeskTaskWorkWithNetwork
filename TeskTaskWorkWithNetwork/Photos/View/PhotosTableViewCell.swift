//
//  TableViewCell.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 2/19/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var photoTitle: UILabel!
    @IBOutlet var photoActivityIndicator: UIActivityIndicatorView!
    @IBOutlet var photoBackView: UIView!
    @IBOutlet var photoFrontView: UIView!
    
    var imageCache = [String: UIImage]()
    var currentImageUrl = ""
    
    
    func configure( with photo: PhotosModel) {
        
        photoActivityIndicator.isHidden = true
        photoActivityIndicator.hidesWhenStopped = true
        
        self.photoFrontView.layer.masksToBounds = true
        self.photoFrontView.layer.cornerRadius = 10
        self.photoFrontView.layer.borderWidth = 1
        
        self.fetchImage(imageUrl: photo.url ?? "")
        
        if let image = imageCache[photo.url ?? ""] {
            photoImageView.image = image
        } else {
            self.currentImageUrl = photo.url ?? ""
            self.fetchImage(imageUrl: photo.url ?? "")
        }
    }
    
    // MARK: Network
    private func fetchImage(imageUrl: String) {
        
        photoActivityIndicator.isHidden = false
        photoActivityIndicator.startAnimating()
        
        NetworkService.fetchImage(imageUrl: imageUrl) { (image) in
            DispatchQueue.main.async {
                if self.currentImageUrl == imageUrl {
                    self.imageCache[imageUrl] = image as? UIImage
                    self.photoImageView.image = image as? UIImage
                }
                self.photoActivityIndicator.stopAnimating()
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
}
