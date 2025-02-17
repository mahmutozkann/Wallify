//
//  FirebaseAuthentication.swift
//  Wallify
//
//  Created by Mahmut Özkan on 5.01.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

func register(email: String, password: String, name: String, surname: String, completion: @escaping (Bool) -> Void){
    
    Auth.auth().createUser(withEmail: email, password: password){ result, error in
        if error != nil{
            print(error!.localizedDescription)
            completion(false)
        }else if let user = result?.user{
            let db = Firestore.firestore()
            db.collection("users").document(user.uid).setData([
                "name": name,
                "surname": surname,
                "email": email,
                "createdAt": Date()
            ]){ error in
                if let error = error {
                    print("Firestore save error: \(error.localizedDescription)")
                    completion(false)
                }else{
                    print("Successfully registered")
                    completion(true)
                }
            }
        }
    }
}

func signIn(email: String, password: String, completion: @escaping (Bool) -> Void){
    Auth.auth().signIn(withEmail: email, password: password){ result, error in
        if error != nil{
            print(error!.localizedDescription)
            completion(false)
        }else{
            completion(true)
        }
    }
}
