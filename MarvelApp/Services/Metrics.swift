//
//  Metrics.swift
//  MarvelApp
//
//  Created by lucas.v.moraes on 19/11/2018.
//  Copyright © 2018 LSolutions. All rights reserved.
//

import UIKit

class Metrics {
    
    fileprivate static let x = UIScreen.main.bounds.width
    fileprivate static let y = UIScreen.main.bounds.height
    
    private static let center = CGPoint(x: x / 2, y: y / 2)
    
    static func getCenter() -> CGPoint {
        return center
    }
}
