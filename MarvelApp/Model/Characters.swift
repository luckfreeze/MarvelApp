//
//  Characters.swift
//  MarvelApp
//
//  Created by Lucas Moraes on 27/04/2018.
//  Copyright © 2018 LSolutions. All rights reserved.
//

import Foundation
import ObjectMapper

class Characters: Mappable {
    
    var id: Int
    var name: String
    var biography: String
    var thumb: CharThumb!
    
    required init?(map: Map) {
        
        id = 0
        name = ""
        biography = ""
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.name <- map["name"]
        self.biography <- map["description"]
        self.thumb <- map["thumbnail"]
    }
}

class CharThumb: Mappable {
    
    var path: String = ""
    var thumbExtention: String = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        self.path <- map["path"]
        self.thumbExtention <- map["extension"]
    }
    
    // Returning the full path of thumb to download
    func getPath() -> String {
        return "\(path).\(thumbExtention)"
    }
}







