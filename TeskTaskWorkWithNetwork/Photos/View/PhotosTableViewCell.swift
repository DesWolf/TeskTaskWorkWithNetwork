//
//  TableViewCell.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 2/19/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import UIKit

// Review: Ячейка не должна знать что-либо о данных. Лучше бы прокидывать просто пропсы/вью модель в неё.
// Логику загрузки кэшируемых картинок отправить в отдельный объект, который принимает на вход imageView, url и присваивает картинку.
// Этот объект лучше бы был единым на приложение, т.к. кэш в приложении.

class PhotosTableViewCell: UITableViewCell {

    // Review: Хороший тон - делать @IBOutlet, и любые вьюшки, содержащиеся в слое презентации приватными.
    // Снаружи конфигурировать их можно только понятным объектом. Например, если у тебя 3 лейбла, один из них скрывается, если текста нет:
    //
    //    struct ViewModel {
    //      let title: String
    //      let subtitle: String
    //      let body: String?
    //    }
    //
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var photoTitle: UILabel!
    @IBOutlet var photoActivityIndicator: UIActivityIndicatorView!
    @IBOutlet var photoBackView: UIView!
    @IBOutlet var photoFrontView: UIView!
    
    private let networkManagerImageData = NetworkManagerImageData()
    private var currentImageUrl = ""
    var imageCache = NSCache<AnyObject, AnyObject>()
    // Review: Типизация нужна. Но это мелочь, по сравнению с тем, что кэш находится внутри ячейки.
    // Каждой ячейки) Должен быть отдельный менеджер/сервис кэша картинок
    
    func configure( with photo: PhotoInfo) {
     
        
        self.photoFrontView.layer.masksToBounds = true
        self.photoFrontView.layer.cornerRadius = 10
        cellShadow()
        
        self.photoTitle.text = photo.title ?? ""
        self.currentImageUrl = String(photo.url?.suffix(10) ?? "")
        // Review: Этот суффикс - первый признак того, что что-то идёт не так.
        // networkImageData не нужен, нужно прямо из корректной URLSession идти за картинкой по урлу
        // :) Зачем возвращать тип из URL в String?
        
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
                    // Review: Сохранять в кэш стоит не в main потоке.
                    self?.imageCache.setObject(image, forKey: self?.currentImageUrl as AnyObject)
                    self?.photoActivityIndicator.stopAnimating()
                }
            }
        }
    }
}
