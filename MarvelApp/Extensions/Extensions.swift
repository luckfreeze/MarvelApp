//
//  Extensions.swift
//  MarvelApp
//
//  Created by Lucas Moraes on 30/04/2018.
//  Copyright © 2018 LSolutions. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func downloadImage(path: String) {
        let url = URL(string: path)
        self.kf.setImage(with: url)
    }
}
