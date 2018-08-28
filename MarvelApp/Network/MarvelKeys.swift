//
//  MarvelKeys.swift
//  MarvelApp
//
//  Created by lucas.v.moraes on 09/08/2018.
//  Copyright © 2018 LSolutions. All rights reserved.
//

import Foundation
import CryptoSwift

struct MarvelKeys {
    static let publicKey = MarvelAccountKeys.publicKey
    static let privateKey = MarvelAccountKeys.privateKey
    static let ts = NSDate().timeIntervalSince1970.description
    static let hash = "\(ts)\(privateKey)\(publicKey)".md5()
}

struct MarvelAccountKeys {
    static let publicKey = "1ad6dfb02cc0e92a9abecc2ebc3ece3c"
    static let privateKey = "25d456b6c331d13a476e66f3e185307fd8247e2b"
}

struct MarvelURL {
    static let characters = "http://gateway.marvel.com:80/v1/public/characters"
    static let character = "http://gateway.marvel.com:80/v1/public/character"
}
