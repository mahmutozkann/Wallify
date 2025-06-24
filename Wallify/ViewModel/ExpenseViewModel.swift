//
//  ExpenseViewModel.swift
//  Wallify
//
//  Created by Mahmut Özkan on 17.05.2025.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class ExpenseViewModel: ObservableObject {
    @Published var expenses: [Expense] = []
    @Published var totalBalance: Double = 0.0
    @Published var userCategories: [(key: String, value: String)] = []
    
    private let db = Firestore.firestore()
    private var userId: String? {
        Auth.auth().currentUser?.uid
    }
    
    init(){
        listenToTotalBalance()
        listenToExpenses()
    }
    
    //MARK: Listen To Total Balance
    private func listenToTotalBalance() {
        guard let userId = userId else {return}
        let userDoc = db.collection("users").document(userId)
        userDoc.addSnapshotListener { snapshot, _ in
            guard let data = snapshot?.data(),
                  let bal = data["totalBalance"] as? Double else { return }
            DispatchQueue.main.async { self.totalBalance = bal }
        }
    }
    
    //MARK: Listen To Expenses
    private func listenToExpenses() {
        guard let userId = userId else {return}
        db.collection("users")
            .document(userId)
            .collection("expenses")
            .order(by: "date", descending: true)
            .addSnapshotListener { snap, _ in
                guard let docs = snap?.documents else { return }
                self.expenses = docs.compactMap { doc in
                    let d = doc.data()
                    guard let category = d["category"] as? String,
                          let amount   = d["amount"]   as? Double,
                          let ts       = d["date"]     as? Timestamp
                    else { return nil }
                    return Expense(
                        id: doc.documentID,
                        category: category,
                        amount: amount,
                        date: ts.dateValue()
                    )
                }
            }
    }
    
    //MARK: TotalBalance
    var formattedBalance: String {
        let fmt = NumberFormatter()
        fmt.numberStyle = .currency
        fmt.currencySymbol = "$"           // ya da Locale’ya göre değiştir
        return fmt.string(from: NSNumber(value: totalBalance)) ?? "$0.00"
    }
    
    //MARK: Pozitif bakiye (income) ekler
    func addIncome(amount: Double, date: Date = Date()) {
        guard let userId = userId else { return }
        let userRef = db.collection("users").document(userId)
        let expRef = userRef.collection("expenses").document()
        
        let data: [String: Any] = [
            "category": "Income",
            "amount": amount,
            "date": Timestamp(date: date)
        ]
        
        // 1) Önce gelir kaydını ekle
        expRef.setData(data) { err in
            guard err == nil else { return }

            // 2) Ardından totalBalance'ı transaction ile güncelle
            self.db.runTransaction({ (transaction, errorPointer) -> Any? in
                let snapshot: DocumentSnapshot
                do {
                    snapshot = try transaction.getDocument(userRef)
                } catch let fetchError as NSError {
                    errorPointer?.pointee = fetchError
                    return nil
                }
                
                guard let currentBalance = snapshot.data()?["totalBalance"] as? Double else {
                    let error = NSError(
                        domain: "AppErrorDomain",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Balance not found"]
                    )
                    errorPointer?.pointee = error
                    return nil
                }
                
                let updatedBalance = currentBalance + amount
                transaction.updateData(["totalBalance": updatedBalance], forDocument: userRef)
                return nil
            }) { (object, error) in
                if let error = error {
                    print("Transaction failed: \(error.localizedDescription)")
                } else {
                    print("Balance updated with transaction")
                }
            }
        }
    }
    
    //MARK: Yeni harcama ekle ve bakiyeyi güncelle
    func addExpense(name: String, category: String, amount: Double, date: Date) {
        let expenseData: [String: Any] = [
            "category": category,
            "amount": amount,
            "date": Timestamp(date: date)
        ]
        guard let userId = userId else {return}
        let userRef = db.collection("users").document(userId)
        let expRef  = userRef.collection("expenses").document()
        
        // 1) Harcamayı ekle
        expRef.setData(expenseData) { err in
            guard err == nil else { return }
            // 2) totalBalance'ı decrement veya increment et
            userRef.updateData([
                "totalBalance": FieldValue.increment(-amount)
            ])
        }
    }
    
    //MARK: Günlük harcama
    var dailyTotal: Double {
        let today = Calendar.current.startOfDay(for: Date())
        return expenses
            .filter { Calendar.current.isDate($0.date, inSameDayAs: today) && $0.category != "Income" }
            .reduce(0) { $0 + $1.amount }
    }
    
    //MARK: Aylık harcama
    var monthlyTotal: Double {
        let now = Date()
        return expenses
            .filter {
                let date = $0.date
                let sameMonth = Calendar.current.isDate(date, equalTo: now, toGranularity: .month)
                let sameYear  = Calendar.current.isDate(date, equalTo: now, toGranularity: .year)
                return sameMonth && sameYear && $0.category != "Income"
            }
            .reduce(0) { $0 + $1.amount }
    }
    
    //MARK: Yıllık harcama
    var yearlyTotal: Double {
        let now = Date()
        return expenses
            .filter {
                Calendar.current.isDate($0.date, equalTo: now, toGranularity: .year)
                && $0.category != "Income"
            }
            .reduce(0) { $0 + $1.amount }
    }
    
    
    //MARK: Haftalık Harcama
    var weeklyExpenseTotal: Double {
        let now = Date()
        guard let weekStart = Calendar.current.dateInterval(of: .weekOfYear, for: now)?.start else {
            return 0
        }
        return expenses
            .filter { $0.date >= weekStart && $0.category != "Income" }
            .reduce(0) { $0 + $1.amount }
    }
    
    //MARK: Haftalık Gelir Total
    var weeklyIncomeTotal: Double {
        let now = Date()
        guard let weekStart = Calendar.current.dateInterval(of: .weekOfYear, for: now)?.start else {
            return 0
        }
        return expenses
            .filter { $0.date >= weekStart && $0.category == "Income" }
            .reduce(0) { $0 + $1.amount }
    }
    
    //MARK: Delete
    func deleteExpense(_ expense: Expense) {
        guard let userId = userId else {return}
        let userRef = db.collection("users").document(userId)
        let expenseRef = userRef.collection("expenses").document(expense.id)
        
        // 1) Firestore'dan harcamayı sil
        expenseRef.delete { error in
            guard error == nil else {
                print("Error deleting expense: \(error!.localizedDescription)")
                return
            }
            
            // 2) Eğer gelir değilse, totalBalance'ı geri ekle
            if expense.category != "Income" {
                userRef.updateData([
                    "totalBalance": FieldValue.increment(expense.amount)
                ])
            } else {
                // Eğer bu bir gelir kaydıysa, totalBalance'ı düş
                userRef.updateData([
                    "totalBalance": FieldValue.increment(-expense.amount)
                ])
            }
        }
    }
    
    //MARK: Total Expenses
    var usedPercentage: Double {
        guard totalBalance > 0 else { return 0 }
        
        let totalExpenses = expenses
            .filter { $0.category != "Income" }
            .reduce(0) { $0 + $1.amount }
        
        return min(totalExpenses / totalBalance, 1.0)
    }
    
    //MARK: Charts
    func categoryDisplayName(for key: String) -> String {
        let allCategories = categories + userCategories
        return allCategories.first(where: { $0.key == key })?.value ?? key
    }
    
    func chartSlices(for range: ChartDateRange) -> [ChartSlice] {
        let now = Date()
        let calendar = Calendar.current
        
        let filteredExpenses: [Expense] = expenses.filter { expense in
            guard expense.category != "Income" else { return false }
            
            switch range {
            case .all:
                return true
            case .thisMonth:
                return calendar.isDate(expense.date, equalTo: now, toGranularity: .month)
            case .thisWeek:
                guard let weekStart = calendar.dateInterval(of: .weekOfYear, for: now)?.start else { return false }
                return expense.date >= weekStart
            case .thisYear:
                return calendar.isDate(expense.date, equalTo: now, toGranularity: .year)
            }
        }
        
        // Harcamaları kategoriye göre grupla
        let grouped = Dictionary(grouping: filteredExpenses) { $0.category }
        
        let colorMap: [String: Color] = [
            "fork.knife": .purple,
            "bus": .indigo,
            "gamecontroller": .green,
            "cart": .pink,
            "party.popper": .orange,
            "ellipsis": .brown
        ]
        
        let userIconColorMap: [String: Color] = [
            "house": .cyan,
            "heart": .red,
            "car": .mint,
            "book": .yellow,
            "paintpalette": .blue,
            "gift": .teal,
            "globe": .gray
        ]
        
        var slices = grouped.map { category, items in
            let total = items.reduce(0) { $0 + $1.amount }
            let displayName = categoryDisplayName(for: category)
            let color = colorMap[category]
                        ?? userIconColorMap[category]
                        ?? .gray
            return ChartSlice(
                value: total,
                color: color,
                label: displayName
            )
        }
        
        // Sabit sıralama
        let categoryOrder = ["Food", "Transportation", "Games", "Shopping", "Social", "Other"]
        slices.sort {
            categoryOrder.firstIndex(of: $0.label) ?? Int.max <
                categoryOrder.firstIndex(of: $1.label) ?? Int.max
        }
        
        return slices
    }
    
    //MARK: Excel
    func exportExpensesToCSV() -> URL? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        var csvString = "Category;Amount;Date\n"  // Noktalı virgül burada önemli!
        
        for expense in expenses {
            let dateStr = dateFormatter.string(from: expense.date)
            csvString += "\(expense.category);\(expense.amount);\(dateStr)\n"
        }
        
        let fileName = "expenses.csv"
        let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        
        do {
            try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
            print("CSV başarıyla yazıldı: \(fileURL)")
            return fileURL
        } catch {
            print("CSV dışa aktarma hatası: \(error.localizedDescription)")
            return nil
        }
    }
    
    //MARK: User Categories
    func fetchUserCategories() {
        guard let userId = userId else {return}
        db.collection("users")
            .document(userId)
            .collection("userCategories")
            .addSnapshotListener { snapshot, _ in
                guard let docs = snapshot?.documents else { return }
                self.userCategories = docs.compactMap {
                    let data = $0.data()
                    guard let icon = data["icon"] as? String,
                          let name = data["name"] as? String else { return nil }
                    return (key: icon, value: name)
                }
            }
    }
    
    func addUserCategory(icon: String, name: String) {
        guard let userId = userId else {return}
        let docRef = db.collection("users")
            .document(userId)
            .collection("userCategories")
            .document()
        docRef.setData([
            "icon": icon,
            "name": name
        ])
    }
}

