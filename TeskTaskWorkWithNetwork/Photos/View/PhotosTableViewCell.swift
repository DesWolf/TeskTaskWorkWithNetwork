//
//  TableViewCell.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 2/19/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    @IBOutlet var photoImage: UIImageView!
    @IBOutlet var photoTitle: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var backView: UIView!
    @IBOutlet var frontView: UIView!
    var currentImageUrl = ""
    
    func configere( with photo: PhotosModel) {
        
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        
        self.photoTitle.text = photo.title
        self.currentImageUrl = photo.url ?? ""
        self.fetchImage(imageUrl: photo.url ?? "")
        
    }
    
    // MARK: Network
    private func fetchImage(imageUrl: String) {
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        NetworkImage.fetchImage(imageUrl: imageUrl) { (image) in
            
            DispatchQueue.main.async {
                if self.currentImageUrl == imageUrl {
                self.photoImage.image = image as? UIImage
                self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoImage.image = nil
    }
}
