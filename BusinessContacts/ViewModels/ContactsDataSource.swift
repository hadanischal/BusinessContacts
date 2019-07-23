//
//  ContactsDataSource.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 5/30/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

protocol UpdateContactDelegate {
    func updateContact(_ data: ContactsModel)
}

class GenericDataSource<T>: NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
    var delegate: UpdateContactDelegate?
    fileprivate let portraitReuseIdentifier = "PortraitCollectionViewCell"
}

class ContactsDataSource: GenericDataSource<ContactsModel>, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: portraitReuseIdentifier, for: indexPath) as! PortraitCollectionViewCell
        let contactsModel = self.data.value[indexPath.row]
        cell.contactsValue = contactsModel
        cell.favoriteBtnTap = {
            if let delegate = self.delegate {
                delegate.updateContact(contactsModel)
            }
        }
        return cell
    }
}
