//
//  UserTableViewCell.swift
//  CoreDataMyTest
//
//  Created by catalina lozano on 16/06/24.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    var user: User? {
        didSet {
            setupData()
        }
    }
    
    private func setupData(){
        guard let user = user else {return}
        /*  if let url = URL(string: user.avatar) {
            userImageView.kf.setImage(with: url)
        }*/
        userNameLabel.text = user.name
        userEmailLabel.text = user.type
    }
    
    override func prepareForReuse() {
        userNameLabel.text = nil
        userEmailLabel.text = nil
       // userImageView.image = nil
    }
}
