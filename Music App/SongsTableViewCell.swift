//
//  SongsTableViewCell.swift
//  Music App
//
//  Created by Kushagra Shukla on 01/05/23.
//

import Foundation
import UIKit

class SongsTableViewCell: UITableViewCell {
    
    let songBackgroundView: UIView = {
      let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        return view
    }()
    
    let artworkImageView:  UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let songTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = UIColor.black
        
        return label
    }()
    
    let songArtist: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor.gray
        
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "songCell")
        
        contentView.addSubview(songBackgroundView)
        songBackgroundView.addSubview(artworkImageView)
        songBackgroundView.addSubview(songTitle)
        songBackgroundView.addSubview(songArtist)
        
        
        NSLayoutConstraint.activate([
        
            songBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            songBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            songBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            songBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            artworkImageView.topAnchor.constraint(equalTo: songBackgroundView.topAnchor, constant: 10),
            artworkImageView.leadingAnchor.constraint(equalTo: songBackgroundView.leadingAnchor, constant: 10),
            artworkImageView.widthAnchor.constraint(equalToConstant: 75),
            artworkImageView.heightAnchor.constraint(equalToConstant: 75),
            
            songTitle.topAnchor.constraint(equalTo: songBackgroundView.topAnchor, constant: 10),
            songTitle.leadingAnchor.constraint(equalTo: artworkImageView.trailingAnchor, constant: 10),
            songTitle.trailingAnchor.constraint(equalTo: songBackgroundView.trailingAnchor, constant: -10),
           
            songArtist.topAnchor.constraint(equalTo: songTitle.bottomAnchor, constant: 5),
            songArtist.leadingAnchor.constraint(equalTo: artworkImageView.trailingAnchor, constant: 10),
            songArtist.trailingAnchor.constraint(equalTo: songBackgroundView.trailingAnchor, constant: -10),
        
        ])
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
