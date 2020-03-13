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
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var backView: UIView!
    @IBOutlet var frontView: UIView!
    var currentImageUrl = ""
    
    func configure( with photo: PhotosModel) {
        
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        
        self.frontView.layer.masksToBounds = true
        self.frontView.layer.cornerRadius = 10
        self.frontView.layer.borderWidth = 1
        
        self.photoTitle.text = photo.title
        self.currentImageUrl = photo.url ?? ""
        self.fetchImage(imageUrl: photo.url ?? "")
    }
    
    // MARK: Network
    private func fetchImage(imageUrl: String) {
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        NetworkService.fetchImage(imageUrl: imageUrl) { (image) in
            DispatchQueue.main.async {
                if self.currentImageUrl == imageUrl {
                    self.photoImageView.image = image as? UIImage
                }
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
}
