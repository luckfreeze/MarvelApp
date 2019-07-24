//
//  CharactersVCExten.swift
//  MarvelApp
//
//  Created by Lucas Moraes on 01/05/2018.
//  Copyright © 2018 LSolutions. All rights reserved.
//

import UIKit

// MARK: Extension for CollectionView Methods - Dels and DtSource
extension CharactersVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let charCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharactersCollectionCell", for: indexPath) as! CharacterCVC
        charCollectionCell.configCell(data: self.myChars[indexPath.row])
        return charCollectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        bringMoreChars(indexP: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        goToChar(row: indexPath.row, indexP: indexPath)
    }
}

extension CharactersVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myChars.count
    }
}

// MARK: Extension for TableView Methods - Dels and DtSource
extension CharactersVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let charTableCell = tableView.dequeueReusableCell(withIdentifier: "CharactersTableCell", for: indexPath) as! CharacterTVC
        charTableCell.configCell(data: self.myChars[indexPath.row])
        return charTableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToChar(row: indexPath.row, indexP: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        bringMoreChars(indexP: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

extension CharactersVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myChars.count
    }
}

// MARK: CollectionView DataSource and Delegate
class MarvelCollectionViewDatasource: NSObject, UICollectionViewDataSource {
    
    var data = [Character]()
    weak var delegate: UICollectionViewDelegate?
    weak var collectionView: UICollectionView?
    
    required init(data: [Character], collectionView: UICollectionView, delegate: UICollectionViewDelegate) {
        self.data = data
        self.collectionView = collectionView
        self.delegate = delegate
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharCVC", for: indexPath) as! CharacterCVC
        cell.configCell(with: data[indexPath.row])
        return cell
    }
    
    func setupCollectionView() {
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self.delegate
        self.collectionView?.reloadData()
    }
}

class MarvelCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    let delegate: CharactersDelegate
    
    init(_ delegate: CharactersDelegate) {
        self.delegate = delegate
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.didSelectCharacter(at: indexPath)
    }
}

// MARK: CollectionView DataSource and Delegate
class MarvelTableViewDatasource: NSObject, UITableViewDataSource {
    
    var data = [Character]()
    weak var delegate: UITableViewDelegate?
    weak var tableView: UITableView?
    
    required init(data: [Character], tableView: UITableView, delegate: UITableViewDelegate) {
        self.data = data
        self.tableView = tableView
        self.delegate = delegate
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let charTableCell = tableView.dequeueReusableCell(withIdentifier: "CharactersTableCell", for: indexPath) as! CharacterTVC
        charTableCell.configCell(with: self.data[indexPath.row])
        return charTableCell
    }
    
    func setupTableView() {
        self.tableView?.dataSource = self
        self.tableView?.delegate = self.delegate
        self.tableView?.reloadData()
    }
}

class MarvelTableViewDelegate: NSObject, UITableViewDelegate {
    let delegate: CharactersDelegate
    
    init(_ delegate: CharactersDelegate) {
        self.delegate = delegate
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.didSelectCharacter(at: indexPath)
    }
}


protocol CharactersDelegate {
    func didSelectCharacter(at index: IndexPath)
}





