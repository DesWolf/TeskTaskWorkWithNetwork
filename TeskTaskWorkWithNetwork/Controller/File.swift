//
//  File.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 2/21/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

//import Foundation
//
//class BatchViewController: UIViewController, UITableViewDataSource{
//
//  @IBOutlet weak var coinTableView: UITableView!
//  
//  var coinArray : [Coin] = []
//  
//  let baseURL = "https://api.coinmarketcap.com/v2/ticker/?"
//  
//  // fetch 15 items for each batch
//  let itemsPerBatch = 15
//  
//  // current row from database
//  var currentRow : Int = 1
//  
//  // URL computed by current row
//  var url : URL {
//    return URL(string: "\(baseURL)start=\(currentRow)&limit=\(itemsPerBatch)")!
//  }
//  
//  // ... skipped viewDidLoad stuff
//    
//  // MARK : - Tableview data source
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    // +1 to show the loading cell at the last row
//    return self.coinArray.count + 1
//  }
//  
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    // if reached last row, load next batch
//    if indexPath.row == self.coinArray.count {
//      let cell = tableView.dequeueReusableCell(withIdentifier: loadingCellIdentifier, for: indexPath) as! LoadingTableViewCell
//      loadNextBatch()
//      return cell
//    }
//
//    // else show the cell as usual
//    let cell = tableView.dequeueReusableCell(withIdentifier: coinCellIdentifier , for: indexPath) as! CoinTableViewCell
//    
//    // get the corresponding post object to show from the array
//    let coin = coinArray[indexPath.row]
//    cell.configureCell(with: coin)
//    
//    return cell
//  }
//  
//  // MARK : - Batch
//  func loadNextBatch() {
//    URLSession(configuration: URLSessionConfiguration.default).dataTask(with: url) { data, response, error in
//      
//      // Parse JSON into array of Car struct using JSONDecoder
//      guard let coinList = try? JSONDecoder().decode(CoinList.self, from: data!) else {
//        print("Error: Couldn't decode data into coin list")
//        return
//      }
//      
//      // contain array of tuples, ie. [(key : ID, value : Coin)]
//      let coinTupleArray = coinList.data.sorted {$0.value.rank < $1.value.rank}
//      for coinTuple in coinTupleArray {
//        self.coinArray.append(coinTuple.value)
//      }
//      
//      // increment current row
//      self.currentRow += self.itemsPerBatch
//      
//      // Make sure to update UI in main thread
//      DispatchQueue.main.async {
//        self.coinTableView.reloadData()
//      }
//      
//    }.resume()
//  }
//
//}
//
//import Foundation
//import CoreData
//import CommonCrypto
//
//private let backgroundOperationQueue = OperationQueue()
//private var urlSession: URLSession = {
//    let configuration = URLSessionConfiguration.default
//    configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
//    return URLSession(configuration: configuration, delegate: nil, delegateQueue: backgroundOperationQueue)
//}()
//
//extension Image {
//    
//    var background: Image {
//        return CDContext.background.object(with: objectID) as! Image
//    }
//    
//    convenience init(_ url: String) {
//        let context = CDContext.background
//        let description = NSEntityDescription.entity(forEntityName: "Image", in: context)!
//        self.init(entity: description, insertInto: context)
//        self.url = url
//    }
//    
//    func getData(completion: @escaping (Data, Bool) -> ()) {
//        
//        let mainCompletion = { (data: Data, animated: Bool) -> () in
//            DispatchQueue.main.async { completion(data, animated) }
//        }
//        
//        if let path = path {
//            backgroundOperationQueue.addOperation {
//                let data = NSData(contentsOfFile: path) as? Data ?? Data()
//                mainCompletion(data, false)
//            }
//        } else {
//            urlSession.dataTask(with: URL(string: url!)!) { data, _, _ in
//                let imagePath = imagesCachePath + "/" + self.url!.md5
//                if let data = data {
//                    mainCompletion(data, true)
//                    if NSData(data: data).write(toFile: imagePath, atomically: true) {
//                        let context = CDContext.background
//                        context.perform {
//                            let image = self.background
//                            image.path = imagePath
//                            try? context.save()
//                        }
//                    }
//                }
//            }.resume()
//        }
//    }
//}
//
//var imagesCachePath: String! = {
//    guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else { return nil }
//    let imagePath = path + "/Images"
//    let fileManager = FileManager.default
//    if !fileManager.fileExists(atPath: imagePath) {
//        do {
//            try fileManager.createDirectory(atPath: imagePath, withIntermediateDirectories: true)
//        } catch {
//            print(error)
//            return nil
//        }
//    }
//    return imagePath
//}()
//
//
//private extension String {
//    var md5: String {
//        var bytes = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
//        CC_MD5(self, CC_LONG(utf8.count), &bytes)
//        return bytes.map { String(format: "%02x", $0) }.joined()
//    }
//}
