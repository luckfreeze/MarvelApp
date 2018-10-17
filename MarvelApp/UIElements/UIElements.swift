//
//  UIElements.swift
//  MarvelApp
//
//  Created by lucas.v.moraes on 28/06/2018.
//  Copyright © 2018 LSolutions. All rights reserved.
//

import UIKit

class Spinner: UIActivityIndicatorView {
    
    let x = UIScreen.main.bounds.width
    let y = UIScreen.main.bounds.height
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        loadConfig()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadConfig() {
        self.hidesWhenStopped = true
        self.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        self.color = UIColor.red
        self.center = CGPoint(x: x / 2, y: y / 2)
    }
    
    func stop() {
        self.stopAnimating()
    }
    func start() {
        self.startAnimating()
    }
} // Spinner


class ErrorButton: UIButton {
    
    var delegate: ErrorButtonDelegate!
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        loadConfig()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadConfig() {
        self.setTitle("Refazer Request", for: UIControlState.normal)
        self.addTarget(self, action: #selector(handlebuttonClicked), for: UIControlEvents.touchUpInside)
        self.frame = CGRect(x: 0, y: 0, width: 240, height: 80)
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor.red
        self.tintColor = UIColor.white
    }
    @objc func handlebuttonClicked() {
        delegate.errorButtonAction()
    }
} // ErrorButton













