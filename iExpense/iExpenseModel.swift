//
//  ExpenseModel.swift
//  iExpense
//
//  Created by Chiraphat Techasiri on 6/3/25.
//

import SwiftData
import Foundation

class ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    let currency: String
}


