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
    
    func logOut() {
        guard let user = Auth.auth().currentUser else { return }
        
        if user.isAnonymous {
            signOutAndDeleteGuestUser { success in
                DispatchQueue.main.async {
                    self.isLoggedIn = !success ? true : false
                }
            }
        } else {
            do {
                try Auth.auth().signOut()
                DispatchQueue.main.async {
                    self.isLoggedIn = false
                }
            } catch {
                print("Error signing out: \(error.localizedDescription)")
            }
        }
    }
    
    /// Anonim kullanıcıyı hem Auth hem Firestore'dan siler
    private func signOutAndDeleteGuestUser(completion: @escaping (Bool) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(false)
            return
        }
        
        let uid = user.uid
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uid)
        
        // 1. Expenses ve userCategories alt koleksiyonlarını sil
        func deleteAllSubcollections(completion: @escaping (Bool) -> Void) {
            let group = DispatchGroup()
            var success = true
            
            // Sil: expenses
            group.enter()
            db.collection("users").document(uid).collection("expenses").getDocuments { snapshot, error in
                if let docs = snapshot?.documents {
                    for doc in docs {
                        group.enter()
                        doc.reference.delete { err in
                            if let err = err {
                                print("Expense silinemedi: \(err.localizedDescription)")
                                success = false
                            }
                            group.leave()
                        }
                    }
                }
                group.leave()
            }
            
            // Sil: userCategories
            group.enter()
            db.collection("users").document(uid).collection("userCategories").getDocuments { snapshot, error in
                if let docs = snapshot?.documents {
                    for doc in docs {
                        group.enter()
                        doc.reference.delete { err in
                            if let err = err {
                                print("Category silinemedi: \(err.localizedDescription)")
                                success = false
                            }
                            group.leave()
                        }
                    }
                }
                group.leave()
            }
            
            group.notify(queue: .main) {
                completion(success)
            }
        }
        
        deleteAllSubcollections { subcollectionsDeleted in
            if subcollectionsDeleted {
                // 2. User dokümanını sil
                userRef.delete { error in
                    if let error = error {
                        print("Kullanıcı dokümanı silinemedi: \(error.localizedDescription)")
                        completion(false)
                        return
                    }
                    
                    print("Kullanıcı dokümanı silindi.")
                    
                    // 3. Auth kullanıcıyı sil
                    user.delete { authError in
                        if let authError = authError {
                            print("Auth silinemedi: \(authError.localizedDescription)")
                            completion(false)
                        } else {
                            print("Anonim kullanıcı Auth'tan silindi.")
                            completion(true)
                        }
                    }
                }
            } else {
                print("Alt koleksiyonlar tamamen silinemedi.")
                completion(false)
            }
        }
    }
    
    func changePassword(newPassword: String, completion: @escaping (Bool, String?) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(false, "Kullanıcı oturumu açık değil.")
            return
        }
        
        user.updatePassword(to: newPassword) { error in
            if let error = error {
                print("Şifre değiştirme hatası: \(error.localizedDescription)")
                completion(false, error.localizedDescription)
            } else {
                print("Şifre başarıyla değiştirildi.")
                completion(true, nil)
            }
        }
    }
    
    func sendPasswordReset(email: String, completion: @escaping (Bool, String?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Şifre sıfırlama e-postası gönderilemedi: \(error.localizedDescription)")
                completion(false, error.localizedDescription)
            } else {
                print("Şifre sıfırlama e-postası gönderildi.")
                completion(true, nil)
            }
        }
    }
}


