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
    
    private let networkManagerImageData = NetworkManagerImageData()
    private var currentImageUrl = ""
    var imageCache = NSCache<AnyObject, AnyObject>()
    
    func configure( with photo: PhotoInfo) {
        photoActivityIndicator.isHidden = true
        photoActivityIndicator.hidesWhenStopped = true
        
        self.photoFrontView.layer.masksToBounds = true
        self.photoFrontView.layer.cornerRadius = 10
        cellShadow()
        
        self.photoTitle.text = photo.title ?? ""
        self.currentImageUrl = String(photo.url?.suffix(10) ?? "")
        
        if let cacheImage = imageCache.object(forKey: currentImageUrl as AnyObject) as? UIImage {
            self.photoImageView.image = cacheImage
        } else {
            fetchImage(imageUrl: currentImageUrl)
        }
    }
    
    func cellShadow() {
        self.photoBackView.layer.cornerRadius = 10
        self.photoBackView.layer.shadowColor = UIColor.black.cgColor
        self.photoBackView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.photoBackView.layer.shadowOpacity = 0.3
        self.photoBackView.layer.shadowRadius = 2.0
        self.photoBackView.clipsToBounds = false
        self.photoBackView.layer.masksToBounds = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
}

// MARK: Network
extension PhotosTableViewCell {
    
    private func fetchImage(imageUrl: String) {
        photoActivityIndicator.isHidden = false
        photoActivityIndicator.startAnimating()
        
        networkManagerImageData.fetchImage(imageUrl: imageUrl) { [weak self] (image, error) in
            guard let image = image else {
                print(error ?? "")
                DispatchQueue.main.async {
                    self?.photoImageView.image = #imageLiteral(resourceName: "noImage")
                }
                return
            }
            DispatchQueue.main.async {
                if self?.currentImageUrl == imageUrl {
                    self?.photoImageView.image = image
                    self?.imageCache.setObject(image, forKey: self?.currentImageUrl as AnyObject)
                    self?.photoActivityIndicator.stopAnimating()
                }
            }
        }
    }
}
