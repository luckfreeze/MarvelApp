//
//  ViewController.swift
//  MarvelApp
//
//  Created by Lucas Moraes on 27/04/2018.
//  Copyright © 2018 LSolutions. All rights reserved.
//

import UIKit

fileprivate enum GridTable {
    case collectionView
    case tableView
}

class CharactersVC: UIViewController, ErrorButtonDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    private let spinner = Spinner()
    private let errorButton = ErrorButton()
    
    private var marvelApi = MarvelAPI()
    
    private(set) var myChars = [Characters]()
    
    private var refrshControl = UIRefreshControl()
    
    private var limit = 20
    private var offSet = 0
    
    private var showAs = GridTable.tableView
    
    var selectedIndexPath: IndexPath?
    
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
        tableView.refreshControl = refrshControl
        
        collectionView.delegate = self
        collectionView.dataSource = self
        //collectionView.refreshControl = refrshControl
        
        errorButton.delegate = self
        
        refrshControl.addTarget(self, action: #selector(handleRefresh), for: UIControl.Event.valueChanged)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Change", style: UIBarButtonItem.Style.plain, target: self, action: #selector(changeTableOrCollection))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(handleRefresh))
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width / 2, height: 245)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
    }
    
    // MARK: NavigationBar Button Functions
    @objc func handleRefresh() {
        getCharacters()
        self.refrshControl.endRefreshing()
    }
    
    @objc func changeTableOrCollection() {
        animateView()
    }
    
    // MARK: ErrorButton Delegate function
    func errorButtonAction() {
        animateWhenGetError()
    }
    
    // MARK: Marvel API Call
    private func getCharacters() {
        marvelApi.limit = limit
        marvelApi.offSet = offSet
        marvelApi.getCharacters { [weak self] (error, chars) in
            
            guard let vc = self else { return }
            
            if error == nil {
                vc.myChars += chars
                vc.collectionView.reloadData()
                vc.tableView.reloadData()
                vc.animateCollectionView()
                vc.errorButton.alpha = 0
            } else {
                vc.view.addSubview(vc.errorButton)
                vc.errorButton.center = vc.view.center
                vc.collectionView.alpha = 0
                vc.tableView.alpha = 0
                vc.spinner.alpha = 0
            }
        }
    }
    
    // MARK: Perform push to next VC
    func goToChar(row: Int, indexP: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Character") as! CharacterVC
        let thumb: UIImage!
        
        switch self.showAs {
        case .tableView:
            let tablV = self.tableView.cellForRow(at: indexP) as? CharactersTVC
            thumb = tablV?.thumb.image
        case .collectionView:
            let collV = self.collectionView.cellForItem(at: indexP) as? CharactersCVC
            thumb = collV?.thumb.image
        }
        
        self.selectedIndexPath = indexP
        
        vc.name = myChars[row].name
        vc.bio = myChars[row].biography
        vc.thumbPath = myChars[row].thumb.getPath()
        vc.image = thumb
    
        self.navigationController?.pushViewController(vc, animated: true)
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
        switch self.showAs {
        case .tableView:
            UIView.animate(withDuration: 0.3) {
                self.collectionView.alpha = 1
                self.tableView.alpha = 0
            }
            self.showAs = .collectionView
        case .collectionView:
            UIView.animate(withDuration: 0.3) {
                self.collectionView.alpha = 0
                self.tableView.alpha = 1
            }
            self.showAs = .tableView
        }
    }
    
    private func animateWhenGetError() {
        UIView.animate(withDuration: 0.4, animations: {
            self.errorButton.alpha = 0
            self.spinner.alpha = 1
        }) { (_) in
            self.getCharacters()
        }
    }
}

// MARK: Push CharsVC/ Update tableView
extension CharactersVC {
    func bringMoreChars(indexP: Int) {
        if indexP == self.myChars.count-1 {
            offSet += 20
            getCharacters()
        }
    }
}

// MARK: Transition Animated protocol
extension CharactersVC: ZoomTransitionDelegate {
    
    func zoomForBackgroundView(for transition: ZoomTransition) -> UIView? {
        return nil
    }
    
    func zoomCharacterImageView(for transition: ZoomTransition) -> UIImageView? {
        let thumbIV: UIImageView!
        switch self.showAs {
        case .tableView:
            let tablV = self.tableView.cellForRow(at: selectedIndexPath!) as? CharactersTVC
            thumbIV = tablV?.thumb
        case .collectionView:
            let collV = self.collectionView.cellForItem(at: selectedIndexPath!) as? CharactersCVC
            thumbIV = collV?.thumb
    }
        return thumbIV
    }
}
