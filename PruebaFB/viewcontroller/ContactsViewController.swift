//
//  MessagesTableTableViewController.swift
//  PruebaFB
//
//  Created by Mariano D'Agostino on 03/07/2019.
//  Copyright © 2019 Mariano D'Agostino. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

protocol GuardadorDeContactos {
    func guardarContacto(contacto: Contacto)
}

class MessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GuardadorDeContactos {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageUser: UIImageView!
    var contactos: [Contacto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageUser.layer.cornerRadius = imageUser.bounds.size.width / 2.0
        if let user = Auth.auth().currentUser {
            imageUser.kf.setImage(with: user.photoURL)
        }
        let ref = Database.database().reference()
            ref.child("Contactos").observe(DataEventType.value) { (snapshot) in
            if let contactosDictionary = snapshot.value as? [String: AnyObject] {
                self.contactos.removeAll()
                for (_,value) in contactosDictionary {
                    if let valueDictionary = value as? [String: AnyObject] {
                        let contacto = Contacto(dictionary: valueDictionary)
                        self.contactos.append(contacto)
                    }
                }
//                self.contactos.sort(by: { (message1, message2) -> Bool in
//                    return UIContentSizeCategory(rawValue: message1.name!) > UIContentSizeCategory(rawValue: message2.name!)
//                })
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell-contact", for: indexPath)

        let contacto = self.contactos[indexPath.row]

        if let customCell = cell as? ContactsTableViewCell {
            customCell.setup(contact: contacto)
        }
        return cell
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
 
    func guardarContacto(contacto: Contacto) {
        contactos.append(contacto)
        tableView.reloadData()
        print(Auth.auth().currentUser?.uid as Any)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if let destination = segue.destination as? AddContactViewController {
            destination.delegateGuardadorDeContacto = self
        }
    }
}
