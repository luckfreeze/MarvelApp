//
//  AlertService.swift
//  MarvelApp
//
//  Created by lucas.v.moraes on 28/06/2018.
//  Copyright © 2018 LSolutions. All rights reserved.
//

import UIKit

class AlertService {
    typealias AlertCompletion = () -> ()
    static func defaultNoAction(in ViewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okAction)
        ViewController.present(alert, animated: true, completion: nil)
    }
    
    static func defaultWithAction(in ViewController: UIViewController, title: String, message: String, onAction: @escaping AlertCompletion) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okBtn = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (_) in
            onAction()
        }
        let cancelBtn = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(cancelBtn)
        alert.addAction(okBtn)
        ViewController.present(alert, animated: true, completion: nil)
    }
}
