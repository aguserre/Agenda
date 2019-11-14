//
//  ViewController.swift
//  PruebaFB
//
//  Created by Mariano D'Agostino on 01/07/2019.
//  Copyright © 2019 Mariano D'Agostino. All rights reserved.
//

import UIKit
import FirebaseUI
import Kingfisher
import FirebaseStorage

class ViewController: UIViewController, FUIAuthDelegate {

    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Inicializamos Firebase UI y asignamos el delegate
        let authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
        
        // Configurar los providers que vamos a usar
        let providers: [FUIAuthProvider] = [FUIEmailAuth(), FUIGoogleAuth()]
        authUI?.providers = providers
        self.descargarLogo()
        

    }
    
    func descargarLogo() -> Void {
        // Traemos la referencia al Storage
        let reference = Storage.storage().reference()
        // Pedimos a Firebase la URL para poder descargar la imagen
        reference.child("ok.png").downloadURL { (url, error) in
            if let url = url {
                self.logoImageView.kf.setImage(with: url)
            }
        }
        
    }

    @IBAction func loginTapped(_ sender: Any) {
        if let authUI = FUIAuth.defaultAuthUI() {
            let authViewController = authUI.authViewController()
            present(authViewController, animated: true) {
            }
        }
    }
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
            
    }
    

}

