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
    
    func configere( with photo: PhotosModel) {
       
        
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        
        self.photoTitle.text = photo.title
        self.fetchImage(imageUrl: photo.thumbnailUrl ?? "")
       
        
     }
    
    func fetchImage(imageUrl: String) {
    
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        NetworkImage.fetchImage(imageUrl: imageUrl) { (image) in
        
        DispatchQueue.main.async {
            self.photoImage.image = image as? UIImage
            self.activityIndicator.stopAnimating()
        }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.image = nil
//              self.accessoryType = .none
    }
}

