//
//  PortraitCollectionViewCell.swift
//  BusinessContacts
//
//  Created by Nischal Hada on 5/30/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

class PortraitCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bagroundView: UIView!
    @IBOutlet var profileImage: UIImageView?
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var emailLabel: UILabel?

    var contactsValue: ContactsModel? {
        didSet {
            guard let contacts = contactsValue else {
                return
            }
            nameLabel?.text = contacts.fullname()
            emailLabel?.text = contacts.email
            if contacts.gender == Gender.male {
                profileImage?.image = #imageLiteral(resourceName: "avatarMale")
            } else {
                profileImage?.image = #imageLiteral(resourceName: "avatarFemale")
            }

        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = ThemeColor.white
        self.bagroundView.backgroundColor = ThemeColor.white
        self.bagroundView.borderWidth = 1
        self.backgroundView?.borderColor = ThemeColor.dimBlackColor
        self.profileImage?.contentMode =   UIView.ContentMode.scaleAspectFit
     }

}
