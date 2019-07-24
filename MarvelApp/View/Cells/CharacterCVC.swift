//
//  CharactersTVC.swift
//  MarvelApp
//
//  Created by Lucas Moraes on 30/04/2018.
//  Copyright © 2018 LSolutions. All rights reserved.
//

import UIKit

class CharacterCVC: UICollectionViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var thumb: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumb.clipsToBounds = true
        thumb.layer.cornerRadius = 5
    }
    
    // Avoiding massive cell for row at indexPath
    func configCell(with data: Character) {
        self.name.text = data.name
        self.thumb.downloadImage(path: data.thumbnail.getCharThumbnail()) {
            
        }
    }
}
