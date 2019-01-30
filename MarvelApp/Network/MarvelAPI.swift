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

class MarvelAPI {
    
    var limit = 0
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
            
            print(response.result)
            print(response.value as Any)
            
            if result.isSuccess {

                guard let value = result.value as? Dictionary<String, AnyObject> else { return }
                let itemMapped = Mapper<Result>().map(JSON: value)!
                charsData = itemMapped.characters
                completion(error, charsData)
            } else {
                completion(error, charsData)
            }
        }
    }
}














