//
//  ImageHelperProtocol.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 7/17/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

protocol ImageHelperProtocol {
    func updateImageForTableViewCell(_ cell: UITableViewCell, inTableView tableView: UITableView, imageURL: String, atIndexPath indexPath: IndexPath)
    func updateImageForCollectionViewCell(_ cell: UICollectionViewCell, inCollectionView collectionView: UICollectionView, imageURL: String, atIndexPath indexPath: IndexPath)
}
