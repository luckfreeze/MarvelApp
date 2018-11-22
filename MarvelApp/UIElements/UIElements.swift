//
//  UIElements.swift
//  MarvelApp
//
//  Created by lucas.v.moraes on 28/06/2018.
//  Copyright © 2018 LSolutions. All rights reserved.
//

import UIKit

class Spinner: UIActivityIndicatorView {
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        loadConfig()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadConfig() {
        self.hidesWhenStopped = true
        self.style = UIActivityIndicatorView.Style.whiteLarge
        self.color = UIColor.red
        self.center = Metrics.getCenter()
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
        self.setTitle("Refazer Request", for: UIControl.State.normal)
        self.addTarget(self, action: #selector(handlebuttonClicked), for: UIControl.Event.touchUpInside)
        self.frame = CGRect(x: 0, y: 0, width: 240, height: 80)
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor.red
        self.tintColor = UIColor.white
    }
    @objc func handlebuttonClicked() {
        delegate.errorButtonAction()
    }
} // ErrorButton













