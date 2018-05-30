//
//  ContactsDataSource.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 5/30/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation
import UIKit

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
    fileprivate let portraitReuseIdentifier = "PortraitCollectionViewCell"
    fileprivate let landscapeReuseIdentifier = "LandscapeCollectionViewCell"
    
}

class ContactsDataSource : GenericDataSource<ContactsModel>, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: portraitReuseIdentifier, for: indexPath) as! PortraitCollectionViewCell
        let feedsValue = self.data.value[indexPath.row]
        cell.contactsValue = feedsValue
        // ImageHelper().updateImageForCollectionViewCell(cell, inCollectionView: collectionView, imageURL: feedsValue.imageRef, atIndexPath: indexPath)
        return cell
    }
}


