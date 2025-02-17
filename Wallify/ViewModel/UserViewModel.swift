//
//  ProfileViewModel.swift
//  Wallify
//
//  Created by Mahmut Özkan on 5.01.2025.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class UserViewModel: ObservableObject {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var email: String = ""
    
    private var db = Firestore.firestore()
    
    func fetchUserData(){
        guard let user = Auth.auth().currentUser else { return }
        
        db.collection("users").document(user.uid).getDocument { document, error in
            if let error = error {
                print("Error fetching user data: \(error.localizedDescription)")
                return
            }
            
            if let data = document?.data() {
                DispatchQueue.main.async {
                    self.name = data["name"] as? String ?? "Unknown"
                    self.surname = data["surname"] as? String ?? "Unknown"
                    self.email = data["email"] as? String ?? "Unknown"
                }
            }
        }
    }
    
    func logOut(){
        do{
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.isLoggedIn = false
            }
        }catch{
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}


