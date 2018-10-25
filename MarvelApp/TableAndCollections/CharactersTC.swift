//
//  CharactersVCExten.swift
//  MarvelApp
//
//  Created by Lucas Moraes on 01/05/2018.
//  Copyright © 2018 LSolutions. All rights reserved.
//

import UIKit

/// Extension for CollectionView Methods - Dels and DtSource
extension CharactersVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myChars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let charCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharactersCollectionCell", for: indexPath) as! CharactersCVC
        charCollectionCell.configCell(data: self.myChars[indexPath.row])
        return charCollectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        bringMoreChars(indexP: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        goToChar(index: indexPath.row)
    }
}

/// Extension for TableView Methods - Dels and DtSource
extension CharactersVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myChars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let charTableCell = tableView.dequeueReusableCell(withIdentifier: "CharactersTableCell", for: indexPath) as! CharactersTVC
        charTableCell.configCell(data: self.myChars[indexPath.row])
        return charTableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToChar(index: indexPath.row)
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















