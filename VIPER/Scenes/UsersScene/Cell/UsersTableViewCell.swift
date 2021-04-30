//
//  UsersTableViewCell.swift
//  VIPER
//
//  Created by Ali Fayed on 30/04/2021.
//

import UIKit
import Kingfisher

class UsersTableViewCell: UITableViewCell {

    @IBOutlet var userName: UILabel!
    @IBOutlet var userAvatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellData(with model: User) {
        self.userName.text = model.userName.capitalized
        let avatarURL = model.userAvatar
        userAvatar.kf.setImage(with: URL(string: avatarURL), placeholder: nil, options: [.transition(.fade(0.7))])
        userAvatar.contentMode = .scaleAspectFill
        userAvatar.layer.masksToBounds = false
        userAvatar.layer.cornerRadius = userAvatar.frame.height/2
        userAvatar.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }

}
