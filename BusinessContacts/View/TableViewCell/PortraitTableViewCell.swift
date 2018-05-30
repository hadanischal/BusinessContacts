//
//  PortraitTableViewCell.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/25/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

class PortraitTableViewCell: UITableViewCell {
    @IBOutlet var bannerImage: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bannerImage.contentMode =   UIViewContentMode.scaleAspectFill
        self.bannerImage .clipsToBounds =  true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
