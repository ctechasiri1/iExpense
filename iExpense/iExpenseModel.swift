//
//  iExpenseModel.swift
//  iExpense
//
//  Created by Chiraphat Techasiri on 6/3/25.
//

import SwiftData
import Foundation

@Model
class ExpenseItem: Identifiable {
    var id = UUID()
    var name: String
    var type: String
    var amount: Double
    var currency: String
    
    init(id: UUID = UUID(), name: String, type: String, amount: Double, currency: String) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
        self.currency = currency
    }
}


