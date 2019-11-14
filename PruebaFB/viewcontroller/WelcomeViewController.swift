//
//  WelcomeViewController.swift
//  PruebaFB
//
//  Created by Agustin Errecalde on 08/07/2019.
//  Copyright © 2019 Mariano D'Agostino. All rights reserved.
//

import UIKit
import FirebaseUI
import Kingfisher
import FirebaseStorage

class WelcomeViewController: UIViewController, FUIAuthDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var inboxButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var sesionInLabel: UILabel!
    @IBOutlet weak var sesionOutLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var logoAgenda: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actualizarPantalla()
        inboxButton.round()
        inboxButton.shine()
        iconImage.image = UIImage(named: "ok")
        imageView.layer.cornerRadius = imageView.bounds.size.width / 2.0
        
        let authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
        
        let providers: [FUIAuthProvider] = [FUIEmailAuth(), FUIGoogleAuth()]
        authUI?.providers = providers
    }
    
    func actualizarPantalla() {
        if let user = Auth.auth().currentUser {
            UIView.animate(withDuration: 0.60) {
                self.logoAgenda.center.y = 180
                self.iconImage.center.y = 168.5
            }
            sesionOutLabel.isHidden = false
            sesionInLabel.isHidden = true
            userLabel.text = user.displayName
            logoutButton.isHidden = false
            logInButton.isHidden = true
            registerButton.isHidden = true
            inboxButton.isHidden = false
            imageView.kf.setImage(with: user.photoURL)
        } else {
            sesionOutLabel.isHidden = true
            sesionInLabel.isHidden = false
            imageView.image = nil
            userLabel.text = nil
            inboxButton.isHidden = true
            logoutButton.isHidden = true
            logInButton.isHidden = false
            registerButton.isHidden = false
            UIView.animate(withDuration: 0.60) {
                self.logoAgenda.center.y = 350.0
                self.iconImage.center.y = 338.5
            }
        }
    }
    
    @IBAction func logInTapped(_ sender: Any) {
        if let authUI = FUIAuth.defaultAuthUI() {
            let authViewController = authUI.authViewController()
            present(authViewController, animated: true) {
                }
            }
    }
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        self.actualizarPantalla()
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        let alert = UIAlertController(title: "LogOut", message: "Seguro desea salir de AgendaDos?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Continuar", style: .default, handler: { action in
            let authUI = FUIAuth.defaultAuthUI()
            do {
                try authUI?.signOut()
            } catch {
                print(error)
            }
            self.actualizarPantalla()
//            self.dismiss(animated: true, completion: nil)
        })
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
            
        })
        alert.addAction(cancel)
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
