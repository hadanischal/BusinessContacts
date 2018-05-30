//
//  ContactsViewController.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 5/30/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
    fileprivate let sectionInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    fileprivate let itemsPerRow: CGFloat = 2
    
    private let refreshControl = UIRefreshControl()
    @IBOutlet var collectionView: UICollectionView!
    
    fileprivate var service : ContactsService! = ContactsService()
    let dataSource = ContactsDataSource()
    lazy var viewModel : ContactsViewModel = {
        let viewModel = ContactsViewModel(service: service, dataSource: dataSource)
        return viewModel
    }()

    override func viewDidLoad(){
        super.viewDidLoad()
        self.CollectionViewSetUp()
        self.collectionView.dataSource = self.dataSource
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.collectionView.reloadData()
        }
        self.setupUIRefreshControl()
        self.serviceCall()
        
    }
    
    func setupUIRefreshControl(){
        refreshControl.addTarget(self, action: #selector(serviceCall), for: UIControlEvents.valueChanged)
        self.collectionView.addSubview(refreshControl)
        
    }
    @objc func serviceCall() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self.viewModel.fetchServiceCall { result in
                //                switch result {
                //                case .success :
                //                    self.title = self.viewModel.title
                //                    break
                //                case .failure :
                //                    break
                //                }
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        refreshControl.endRefreshing()
    }
}


// MARK: UICollectionViewDelegateFlowLayout

extension ContactsViewController : UICollectionViewDelegateFlowLayout {
    
    func CollectionViewSetUp() -> Void{
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        self.collectionView.collectionViewLayout = layout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0 //0.0
        self.collectionView.backgroundColor = ThemeColor.collectionViewBackgroundColor
        self.collectionView.showsHorizontalScrollIndicator = false
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = widthPerItem + 21
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        
        return 0
    }
    
}

extension ContactsViewController{
    
    // MARK: - Lazy Loading of cells
    func loadImagesForOnscreenRows() {
        self.collectionView.reloadData()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadImagesForOnscreenRows()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate { loadImagesForOnscreenRows() }
    }
    
}




