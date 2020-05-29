//
//  ViewController.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 2/19/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import UIKit

// Review: Хочется сократить, имя длинное, но, лучше не надо :)
// В коде не страшно, когда будет let vc = UsersViewController, но вот тип лучше делать развернутым) Иначе могут случиться разночтения.
// Контроллеры бывают разные. ContainerController, ModelController, NavigationController, ContentController.
// Всё зависит от нейминга, и лучше тут не сокращать
class UsersVC: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    var users = [User]()
    var albums = [Album]()
    private let networkManagerMainData =  NetworkManagerMainData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsersData()
        fetchAlbumsData()
        self.tableView.tableFooterView = UIView()
    }
    
    @IBAction func updateUsers(_ sender: Any) {
        fetchUsersData()
        fetchAlbumsData()
        
    }
}

// MARK: Network
extension UsersVC {
    private func fetchUsersData() {
        networkManagerMainData.fetchUsersData() { [weak self]  (users, error)  in
            guard let users = users else {
                print(error ?? "")
                    DispatchQueue.main.async {
                        self?.alertNetwork(message: error ?? "")
                    }
                    return
                }
            self?.users = users
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func fetchAlbumsData() {
        networkManagerMainData.fetchAlbumData() { [weak self] (albums, error) in
            guard let albums = albums else {
                print(error ?? "")
                DispatchQueue.main.async {
                    self?.alertNetwork(message: error ?? "")
                }
                return
            }
            self?.albums = albums
            
        }
    }
}


// MARK: Navigation
extension UsersVC {
  // Review: segue очень ненадёжный инструмент, хоть и можно сказать,что это вопрос выбора/договоренностей.
  // Его минусы:
  // - разносит логику между XIB/кодом
  // - не строго типизирован (если не использовать генераторы кода)
  // - создаёт следующий контроллер сам, а это значит, что проставить зависимости в тот контроллер можно забыть,
  //  создать вообще без зависимостей. Лучше определять все зависимости контроллера в init(), например для UsersVC:
  //
  //  init(networkManager: NetworkManagerMainData) {
  //    self.networkManager = networkManager
  //    super.init(nibName: nil, bundle: nil)
  //  }
  //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "photosVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let user = users[indexPath.row]
            let photosVC = segue.destination as! PhotosVC
            let filterAlbums = albums.filter{ $0.userId == user.id }
            photosVC.albumsIDs = filterAlbums.compactMap { $0.id }
        }
    }
}

// MARK: TableViewDataSource
extension UsersVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

      // Review: Эта ячейка очень похожа на обычную UITableViewCell с конфигурацией в виде .accessoryType = .disclosureIndicator.
      // Можно было не создавать её в сториборде, но это мелочь)
        let cell = tableView.dequeueReusableCell(withIdentifier: "usersVCCell", for: indexPath) as! UsersTableViewCell
        let user = users[indexPath.row]
        cell.configere(with: user)
        return cell
    }
}

//MARK: Alert
extension UsersVC  {
    func alertNetwork(message: String) {
        UIAlertController.alert(title:"Error", msg:"\(message)", target: self)
    }
}


