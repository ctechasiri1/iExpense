//
//  ContentView.swift
//  iExpense
//
//  Created by Chiraphat Techasiri on 10/22/24.
//

import SwiftData
import SwiftUI

struct dismissView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Text("Cancel")
        }
        
    }
}

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [ExpenseItem]
    
    @State private var selectedFilter: String = "All"
    @State private var showAddExpense = false
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount)
    ]
    
    let filters = ["All", "Personal", "Business"]
    
    var body: some View {
        NavigationStack {
            List {
                if selectedFilter == "All" {
                    iExpenseView(expenseType: nil, sortOrder: sortOrder)
                } else {
                    iExpenseView(expenseType: selectedFilter, sortOrder: sortOrder)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Name Expense", systemImage: "plus") {
                    showAddExpense.toggle()
                }
                
                Menu("Filter", systemImage: "arrow.up.arrow.down") {
                    Picker("Filter", selection: $selectedFilter) {
                        ForEach(filters, id: \.self) {
                            Text($0)
                        }
                    }
                }
            }
            .sheet(isPresented: $showAddExpense) {
                AddView(viewModel: iExpenseViewModel())
            }
        }
    }
}

#Preview {
    ContentView()
}

