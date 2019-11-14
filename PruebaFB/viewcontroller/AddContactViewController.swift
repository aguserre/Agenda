//
//  AddContactViewController.swift
//  PruebaFB
//
//  Created by Agustin Errecalde on 10/07/2019.
//  Copyright © 2019 Mariano D'Agostino. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import IQKeyboardManager

class AddContactViewController: UIViewController {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var empresaTxt: UITextField!
    var emailValid: Bool = false
    
    var delegateGuardadorDeContacto: GuardadorDeContactos?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTxt.text = "No email"
        empresaTxt.text = "Personal"
    }
    
    @IBAction func saveTapped(_ sender: Any) {

        let alert = UIAlertController(title: "Agenda", message: "Seguro desea guardar el contacto?", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let ok = UIAlertAction(title: "Continuar", style: .default, handler: { action in
            
            if self.nameTxt.text != "" && self.phoneTxt.text != "" {
                let email = self.emailTxt.text ?? "No email"
                self.emailValid = self.isValidEmail(email: email)
                if self.emailValid || (self.emailValid == false && email == "No email") {
                        self.confAndAddContact()
                        self.dismiss(animated: true, completion: nil)
    
                } else {
                        self.alertaEmailErroneo()
                }
            } else {
                self.alertaCamposObligatorios()
            }
        })
        alert.addAction(cancel)
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func confAndAddContact () {
        let email = self.emailTxt.text
        let name = self.nameTxt.text
        let phone = self.phoneTxt.text
        let empresa = self.empresaTxt.text
        let ref = Database.database().reference()
        let newContact = Contacto(dictionary: (["name":name , "tel":phone , "email":email , "empresa":empresa ?? "Personal"]) as [String : AnyObject])
        self.delegateGuardadorDeContacto?.guardarContacto(contacto: newContact)
        ref.child("Contactos").childByAutoId().setValue(newContact.toDictionary())
    }
    func alertaEmailErroneo () {
        let alert3 = UIAlertController(title: "Error", message: "Email erroneo", preferredStyle: .alert)
        let cancel2 = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert3.addAction(cancel2)
        DispatchQueue.main.async(execute: {
            self.present(alert3, animated: true)
        })
    }
    func alertaCamposObligatorios () {
        let alert2 = UIAlertController(title: "Error", message: "Los campos nombre y telefono son obligatorios", preferredStyle: .alert)
        let cancel2 = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert2.addAction(cancel2)
        DispatchQueue.main.async(execute: {
            self.present(alert2, animated: true)
        })
        
    }
}
