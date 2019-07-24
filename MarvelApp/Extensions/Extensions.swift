//
//  Extensions.swift
//  MarvelApp
//
//  Created by Lucas Moraes on 30/04/2018.
//  Copyright © 2018 LSolutions. All rights reserved.
//

import UIKit
import Nuke

extension UIImageView {
    func downloadImage(path: String, completion: @escaping () -> Void) {
        let pathUrl = URL(string: path)!
        Nuke.loadImage(with: pathUrl, options: ImageLoadingOptions.shared, into: self, progress: nil) { (_, _) in
            completion()
        }
    }
}
