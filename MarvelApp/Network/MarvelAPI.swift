//
//  API.swift
//  MarvelApp
//
//  Created by Lucas Moraes on 27/04/2018.
//  Copyright © 2018 LSolutions. All rights reserved.
//

import Foundation
import Alamofire

class MarvelAPI {
    
    enum MarvelAPIError {
        case Error
        case NoError
    }
    
    var limit = 0
    var offSet = 0
    
    private var authParams: Parameters?
    
    typealias MarvelCompletion = (MarvelAPIError, [Character]) -> Void
    
    func getCharacters(completion: @escaping MarvelCompletion) {
        
        var charsData = [Character]()
        
        authParams = [
            "apikey": MarvelKeys.publicKey,
            "ts": MarvelKeys.ts,
            "hash": MarvelKeys.hash,
            "limit": self.limit,
            "offset": self.offSet
        ]
        
        Alamofire.request(MarvelURL.characters, parameters: authParams).responseJSON { response in
            
            let result = response.result
            
            print("\n\n - RESPONSE:")
            print(response.result)
            print("\n - STATUS CODE:")
            print(response.response!.statusCode)
            print("\n - VALUE:")
            print(response.value!)
            
            if result.isSuccess {
                
                guard let data = response.data else {
                    completion(MarvelAPIError.Error, charsData)
                    return
                }
                let charsMapped = try? JSONDecoder().decode(Data.self, from: data)
                charsData = (charsMapped?.data.results)!
                completion(MarvelAPIError.NoError, charsData)
            } else {
                completion(MarvelAPIError.Error, charsData)
            }
        }
    }
    
    private func printSystem(_ object: DataResponse<Any>) {
        
        print("\n\n - RESPONSE:")
        print(object.result)
        print("\n - STATUS CODE:")
        print(object.response!.statusCode)
        print("\n - VALUE:")
        print(object.value!)
    }
}














