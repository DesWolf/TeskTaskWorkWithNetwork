//
//  TableViewCell.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 2/19/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import UIKit

//protocol IndexTableRow: AnyObject {
//    var indexTableRow: Int { get }
//}

class PhotosTableViewCell: UITableViewCell {

    @IBOutlet var photoImage: UIImageView!
    @IBOutlet var photoTitle: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var backView: UIView!
    @IBOutlet var frontView: UIView!
   
//    var cache:NSCache<AnyObject, AnyObject>!
//    private let cache = ImageCache()
    
    func configere( with photo: PhotosModel) {
        
        
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        
        self.photoTitle.text = photo.title
        self.fetchImage(imageUrl: photo.url ?? "")
//        self.cache = NSCache()
        
     }
    
    func fetchImage(imageUrl: String) {
    
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        NetworkImage.fetchImage(imageUrl: imageUrl) { (image) in
        
        DispatchQueue.main.async {
            
            
            self.photoImage.image = image as? UIImage
          //  self.cache.setObject(photoImage, forKey: (indexPath as NSIndexPath).row as AnyObject)
            self.activityIndicator.stopAnimating()
        }
    }
}

    override func prepareForReuse() {
        super.prepareForReuse()
        photoImage?.image = nil
//              NetworkService.fetchData.cancelrequest()
    }
}
