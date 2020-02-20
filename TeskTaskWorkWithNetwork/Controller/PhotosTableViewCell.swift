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
        self.photoTitle.text = photo.thumbnailUrl
         
     }
}
