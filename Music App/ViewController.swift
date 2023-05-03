//
//  ViewController.swift
//  Music App
//
//  Created by Kushagra Shukla on 28/04/23.
//  Copyright © 2023 Kushagra Shukla. All rights reserved.
//

import UIKit
import MusicKit

class ViewController: UIViewController, UISearchResultsUpdating {
  
    
    let searchController = UISearchController()
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SongsTableViewCell.self, forCellReuseIdentifier: "songCell")
        tableView.rowHeight = 100
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        return tableView
    }()
    
    private let request: MusicCatalogSearchRequest = {
        var request = MusicCatalogSearchRequest(term: "Blinding Lights", types: [Song.self])
        request.limit = 10
        
        return request
    }()
    
    var songs = [Songs]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        //MARK: - TABLE VIEW
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)

        view.backgroundColor = UIColor(red: 28 / 255, green: 29 / 255, blue: 31 / 255, alpha: 1)
        searchController.searchResultsUpdater = self
        
        //Customizing Search Bar
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "search song", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor.white
        }
        
        searchController.searchBar.tintColor = UIColor.black
        
        //End
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchMusic(request)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(red: 28 / 255, green: 29 / 255, blue: 31 / 255, alpha: 1)
        
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        //
    }
    
    //clean music request
    func searchMusic(_ request: MusicCatalogSearchRequest) {
        
        Task {
            
            //Request Permission
            let status = await MusicAuthorization.request()
            
            switch status {
                
            case .authorized:
                print("Permission granted.")
                //Request -> Response
                do {
                    let result = try await request.response()
                    self.songs = result.songs.compactMap({
                        
                        return .init(name: $0.title, artist: $0.artistName, image: $0.artwork?.url(width: 250, height: 250), track: $0.url)
                    })
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } catch {
                    print(String(describing: error))
                }
                break
                
            case .denied:
                print("Permission denied.")
                return
                
            default:
                return
            }
            
            
        }
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.layoutSubviews()
        cell.layoutIfNeeded()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as! SongsTableViewCell
        
        let song = songs[indexPath.row]
        
//        cell.artworkImageView.sd_setImage(with: song.track)
        cell.songTitle.text = song.name
        cell.songArtist.text = song.artist
        
        
        return cell
    }
    
}
