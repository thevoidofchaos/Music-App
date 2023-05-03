//
//  Songs.swift
//  Music App
//
//  Created by Kushagra Shukla on 30/04/23.
//

import Foundation

struct Songs: Identifiable {
    
    var id = UUID()
    let name: String
    let artist: String
    let image: URL?
    let track: URL?
}

