//
//  iExpenseViewModel.swift
//  iExpense
//
//  Created by Chiraphat Techasiri on 6/3/25.
//

import SwiftData
import Foundation

class iExpenseViewModel: ObservableObject {
    
    func addItem(name: String, type: String, amount: Double, currency: String, modelContext: ModelContext) {
        let item = ExpenseItem(name: name, type: type, amount: amount, currency: currency)
        modelContext.insert(item)
    }
    
    func removeItem(items: [ExpenseItem], at offsets: IndexSet, modelContext: ModelContext) {
        for index in offsets {
            let item = items[index]
            modelContext.delete(item)
        }
    }
}

