//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Chiraphat Techasiri on 10/21/24.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: ExpenseItem.self)
        }
    }
}
