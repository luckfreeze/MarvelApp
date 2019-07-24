//
//  Characters.swift
//  MarvelApp
//
//  Created by Lucas Moraes on 27/04/2018.
//  Copyright © 2018 LSolutions. All rights reserved.
//

import Foundation

class Data: Codable {
    var data: Result
}

class Result: Codable {
    var results: [Character]
}

class Character: Codable {
    var id: Int
    var name: String
    var description: String
    var thumbnail: CharThumb
}

class CharThumb: Codable {
    var path: String
    var thumbExtention: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbExtention = "extension"
    }
    
    func getCharThumbnail() -> String {
        return "\(path).\(thumbExtention)"
    }
}




