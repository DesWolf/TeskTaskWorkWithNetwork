//
//  File.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 2/21/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

//import Foundation
//
//final class ImageCache {
//
//    // 1st level cache, that contains encoded images
//    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
//        let cache = NSCache<AnyObject, AnyObject>()
//        cache.countLimit = config.countLimit
//        return cache
//    }()
//    // 2nd level cache, that contains decoded images
//    private lazy var decodedImageCache: NSCache<AnyObject, AnyObject> = {
//        let cache = NSCache<AnyObject, AnyObject>()
//        cache.totalCostLimit = config.memoryLimit
//        return cache
//    }()
//    private let lock = NSLock()
//    private let config: Config
//
//    struct Config {
//        let countLimit: Int
//        let memoryLimit: Int
//
//        static let defaultConfig = Config(countLimit: 100, memoryLimit: 1024 * 1024 * 100) // 100 MB
//    }
//
//    init(config: Config = Config.defaultConfig) {
//        self.config = config
//    }
//}
//
//extension ImageCache: ImageCacheType {
//    func insertImage(_ image: UIImage?, for url: URL) {
//        guard let image = image else { return removeImage(for: url) }
//        let decodedImage = image.decodedImage()
//
//        lock.lock(); defer { lock.unlock() }
//        imageCache.setObject(decodedImage, forKey: url as AnyObject)
//        decodedImageCache.setObject(image as AnyObject, forKey: url as AnyObject, cost: decodedImage.diskSize)
//    }
//
//    func removeImage(for url: URL) {
//        lock.lock(); defer { lock.unlock() }
//        imageCache.removeObject(forKey: url as AnyObject)
//        decodedImageCache.removeObject(forKey: url as AnyObject)
//    }
//}
//
//extension ImageCache {
//    func image(for url: URL) -> UIImage? {
//        lock.lock(); defer { lock.unlock() }
//        // the best case scenario -> there is a decoded image
//        if let decodedImage = decodedImageCache.object(forKey: url as AnyObject) as? UIImage {
//            return decodedImage
//        }
//        // search for image data
//        if let image = imageCache.object(forKey: url as AnyObject) as? UIImage {
//            let decodedImage = image.decodedImage()
//            decodedImageCache.setObject(image as AnyObject, forKey: url as AnyObject, cost: decodedImage.diskSize)
//            return decodedImage
//        }
//        return nil
//    }
//}
//
//extension ImageCache {
//    subscript(_ key: URL) -> UIImage? {
//        get {
//            return image(for: key)
//        }
//        set {
//            return insertImage(newValue, for: key)
//        }
//    }
//}
