//
//  CharacterVC.swift
//  MarvelApp
//
//  Created by Lucas Moraes on 30/04/2018.
//  Copyright © 2018 LSolutions. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterVC: UIViewController {
    
    @IBOutlet weak var imageThumb: UIImageView!
    @IBOutlet weak var biographyLbl: UITextView!

    var name: String?
    var thumbPath: String?
    var image: UIImage?
    var bio: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = name
        imageThumb.image = image
        self.biographyLbl.text = (bio?.isEmpty)! ? "No description" : bio
    }
}

extension CharacterVC: ZoomTransitionDelegate {
    func zoomCharacterImageView(for transition: ZoomTransition) -> UIImageView? {
        return imageThumb
    }
    
    func zoomForBackgroundView(for transition: ZoomTransition) -> UIView? {
        return nil
    }
}
