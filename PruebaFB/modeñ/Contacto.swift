//
//  Contacto.swift
//  PruebaFB
//
//  Created by Agustin Errecalde on 10/07/2019.
//  Copyright © 2019 Mariano D'Agostino. All rights reserved.
//

import Foundation

class Contacto {
    
    var name: String
    var telephone: String
    var email: String?
    var empresa: String?
    
    init(name: String, telephone: String, email: String?, empresa: String?) {
        self.name = name
        self.telephone = telephone
        self.email = email
        self.empresa = empresa
    }
    
    init(dictionary: [String: AnyObject]) {
        self.name = dictionary["name"] as? String ?? ""
        self.telephone = dictionary["tel"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? "no email"
        self.empresa = dictionary["empresa"] as? String ?? "Personal"

    }
    
    func toDictionary() -> [String: AnyObject] {
        return ["name": name, "tel": telephone, "email": email, "empresa": empresa] as [String: AnyObject]
    }
    
}
