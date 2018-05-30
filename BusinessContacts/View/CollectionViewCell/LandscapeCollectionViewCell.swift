//
//  LandscapeCollectionViewCell.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 5/30/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

class LandscapeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bagroundView: UIView!
    @IBOutlet var profileImage: UIImageView?
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var emailLabel: UILabel?

    
    var contactsValue : ContactsModel? {
        didSet {
            guard let contacts = contactsValue else {
                return
            }
            nameLabel?.text = contacts.first_name
            emailLabel?.text = contacts.email

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bagroundView.backgroundColor = ThemeColor.contentViewBackgroundColor
        self.profileImage?.contentMode =   UIViewContentMode.scaleAspectFit
     }
    
    
}
