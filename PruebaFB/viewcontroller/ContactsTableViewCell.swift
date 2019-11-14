//
//  ContactsTableViewCell.swift
//  PruebaFB
//
//  Created by Agustin Errecalde on 19/07/2019.
//  Copyright © 2019 Mariano D'Agostino. All rights reserved.
//

import UIKit
import FirebaseStorage

class ContactsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var empresaLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var imageContact: UIImageView!
    
    func setup(contact: Contacto) {
        nameLabel.text = contact.name
        phoneLabel.text = contact.telephone
        empresaLabel.text = contact.empresa
        emailLabel.text = contact.email
            let reference = Storage.storage().reference()
        
            if empresaLabel.text == "DH" || empresaLabel.text == "Digital House" as String {
                    reference.child("dh.png").downloadURL { (url, error) in
                        if let url = url {
                            self.imageContact.kf.setImage(with: url)
                        }
                    }
                } else {
                reference.child("company.png").downloadURL { (url, error) in
                    if let url = url {
                        self.imageContact.kf.setImage(with: url)
                        }
                }
          }
    }
}
