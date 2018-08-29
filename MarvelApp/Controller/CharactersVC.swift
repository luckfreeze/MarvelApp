//
//  ViewController.swift
//  MarvelApp
//
//  Created by Lucas Moraes on 27/04/2018.
//  Copyright © 2018 LSolutions. All rights reserved.
//

import UIKit

enum GridTable {
    case collectionView
    case tableView
}

class CharactersVC: UIViewController, ErrorButtonDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    private let spinner = Spinner()
    private let errorButton = ErrorButton()
    
    private var marvelApi = MarvelAPI()
    
    var myChars = [Characters]()
    
    private var refrshControl = UIRefreshControl()
    
    private var limit = 20
    private var offSet = 0
    
    private var showAs = GridTable.collectionView
    
    // MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        firstConfig()
        getCharacters()
    }
    
    // MARK: Fist Configuration/ ViewDidLoad
    private func firstConfig() {
        
        view.addSubview(spinner)
        spinner.start()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        errorButton.delegate = self
        
//        collectionView.refreshControl = refrshControl
//        refrshControl.addTarget(self, action: #selector(handleRefresh), for: UIControlEvents.valueChanged)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Change", style: UIBarButtonItemStyle.plain, target: self, action: #selector(changeTableCollection))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: self, action: #selector(handleRefresh))
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width / 2, height: 245)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
    }
    
    
    @objc func handleRefresh() {
        getCharacters()
        self.refrshControl.endRefreshing()
    }
    
    @objc func changeTableCollection() {
        animateView()
    }
    
    // MARK: ErrorButton Delegate function
    internal func errorButtonAction() {
        getCharacters()
    }
    
    // MARK: API Call
    private func getCharacters() {
        marvelApi.limit = limit
        marvelApi.offSet = offSet
        marvelApi.getCharacters { [weak self] (error, chars) in
            
            if error == nil {
                self?.myChars += chars
                self?.collectionView.reloadData()
                self?.tableView.reloadData()
                self?.animateCollectionView()
                self?.errorButton.alpha = 0
            } else {
                self?.view.addSubview((self?.errorButton)!)
                self?.errorButton.center = (self?.view.center)!
                self?.collectionView.alpha = 0
                self?.tableView.alpha = 0
                self?.spinner.alpha = 0
            }
        }
    }
}

// MARK: Animations
extension CharactersVC {
    private func animateCollectionView() {
        UIView.animate(withDuration: 0.7) {
            self.spinner.alpha = 0
            self.collectionView.alpha = 1
            self.spinner.stopAnimating()
        }
    }
    
    private func animateView() {
        switch showAs {
        case .tableView:
            UIView.animate(withDuration: 0.3) {
                self.collectionView.alpha = 0
                self.tableView.alpha = 1
            }
            showAs = .collectionView
        case .collectionView:
            UIView.animate(withDuration: 0.3) {
                self.collectionView.alpha = 1
                self.tableView.alpha = 0
            }
            showAs = .tableView
        }
    }
}

// MARK: Push CharsVC/ Update tableView
extension CharactersVC {
    func goToChar(index: Int) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Character") as! CharacterVC
        vc.name = myChars[index].name
        vc.bio = myChars[index].biography
        vc.thumbPath = myChars[index].thumb.getPath()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func bringMoreChars(indexP: Int) {
        if indexP == self.myChars.count-1 {
            offSet += 20
            getCharacters()
        }
    }
}










