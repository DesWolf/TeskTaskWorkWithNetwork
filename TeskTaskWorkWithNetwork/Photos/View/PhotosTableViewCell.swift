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
    
    var currentImageUrl = ""
    
    func configure( with photo: Photos) {
        photoActivityIndicator.isHidden = true
        photoActivityIndicator.hidesWhenStopped = true
        
        self.photoFrontView.layer.masksToBounds = true
        self.photoFrontView.layer.cornerRadius = 10
        self.photoBackView.layer.cornerRadius = 10
        self.photoBackView.layer.shadowColor = UIColor.black.cgColor
        self.photoBackView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.photoBackView.layer.shadowOpacity = 0.3
        self.photoBackView.layer.shadowRadius = 2.0
        self.photoBackView.clipsToBounds = false
        self.photoBackView.layer.masksToBounds = false
        
        self.photoTitle.text = photo.title ?? ""
        self.currentImageUrl = photo.url ?? ""
        self.fetchImage(imageUrl: photo.url ?? "")
    }
    
    // MARK: Network
    private func fetchImage(imageUrl: String) {
        photoActivityIndicator.isHidden = false
        photoActivityIndicator.startAnimating()
        
        NetworkService.fetchImage(imageUrl: imageUrl) { (image) in
            DispatchQueue.main.async {
                if self.currentImageUrl == imageUrl {
                    self.photoImageView.image = image
                    self.photoActivityIndicator.stopAnimating()
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
}

extension UIView {
    func makeShadow() {
        
    }
}
