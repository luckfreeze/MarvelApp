//
//  API.swift
//  MarvelApp
//
//  Created by Lucas Moraes on 27/04/2018.
//  Copyright © 2018 LSolutions. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import CryptoSwift

struct MarvelKeys {
    static let publicKey = "1ad6dfb02cc0e92a9abecc2ebc3ece3c"
    static let privateKey = "25d456b6c331d13a476e66f3e185307fd8247e2b"
    static let ts = NSDate().timeIntervalSince1970.description
    static let hash = "\(ts)\(privateKey)\(publicKey)".md5()
}

struct MarvelURL {
    static let characters = "http://gateway.marvel.com:80/v1/public/characters"
    static let character = "http://gateway.marvel.com:80/v1/public/character"
}

class MarvelAPI {
    
    var limit = 20
    var offSet = 0
    
    private var authParams: Parameters?
    
    typealias MarvelCompletion = (Error?, [Characters]) -> Void
    
    func getCharacters(completion: @escaping MarvelCompletion) {
        
        var charsData = [Characters]()
        
        authParams = [
            "apikey": MarvelKeys.publicKey,
            "ts": MarvelKeys.ts,
            "hash": MarvelKeys.hash,
            "limit": self.limit,
            "offset": self.offSet
        ]
        
        Alamofire.request(MarvelURL.characters, parameters: authParams).responseJSON { response in
            
            let error = response.error
            let result = response.result
            
            if result.isSuccess {
                if let value = result.value as? Dictionary<String, AnyObject> {
                    if let data = value["data"] as? Dictionary<String, AnyObject> {
                        if let items = data["results"] as? [Dictionary<String, AnyObject>] {
                            for item in items {
                                let itemMapped = Mapper<Characters>().map(JSON: item)
                                charsData.append(itemMapped!)
                                
                            }
                        }
                        
                    }
                }
                
                completion(error, charsData)
            } else {
                completion(error, charsData)
            }
        }
    }
}














