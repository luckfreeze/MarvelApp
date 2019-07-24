//
//  CharactersTVC.swift
//  MarvelApp
//
//  Created by Lucas Moraes on 01/05/2018.
//  Copyright © 2018 LSolutions. All rights reserved.
//

import UIKit

class CharacterTVC: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var biography: UILabel!
    @IBOutlet weak var thumb: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumb.clipsToBounds = true
        thumb.layer.cornerRadius = 5
    }
    
    // Avoiding massive cell for row at indexPath
    func configCell(with data: Character) {
        self.name.text = data.name
        self.biography.text = data.description.isEmpty ? "No description" : data.description
            //data.biography.isEmpty ? "No description" : data.biography
        self.thumb.downloadImage(path: data.thumbnail.getCharThumbnail()) {
            
        }
    }
}
