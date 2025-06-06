//
//  ContentView.swift
//  iExpense
//
//  Created by Chiraphat Techasiri on 10/22/24.
//

import SwiftData
import SwiftUI

struct colorChangeModifier: ViewModifier {
    
    var amount: Double
    
    func body(content: Content) -> some View {
        if amount < 10 {
            content
                .foregroundColor(Color.red)
        } else if amount < 100 {
            content
                .foregroundColor(Color.blue)
        } else if amount > 100 {
            content
                .foregroundColor(Color.green)
        }
    }
}

extension View {
    func colorChange(amount: Double) -> some View {
        self.modifier(colorChangeModifier(amount: amount))
    }
}

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

struct iExpenseView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [ExpenseItem]
    @StateObject var viewModel: iExpenseViewModel

    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Add Expense") {
                    AddView()
                }
                ForEach(expenses) { expense in
                    if expense.type == "Personal" 
                }
                
                
                
                
                if viewModel.expenseItem.type == "Personal" {
                    Section("Personal Expense") {
                        ForEach(personalExpenses.items, id: \.id) { item in
                            if item.type == "Personal" {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                            .font(.headline)
                                        
                                        Text(item.type)
                                    }
                                    
                                    Spacer()
                                    
                                    Text(item.amount, format: .currency(code: item.currency))
                                        .colorChange(amount: item.amount)
                                }
                            }
                        }
                        
                        //This modifier only exists for ForEach
                        .onDelete(perform: viewModel.removePersonalItems(at: <#T##IndexSet#>))
                    }
                }
                
                if viewModel.expenseItem.type == "Business" {
                    Section("Business Expense") {
                        ForEach(businessExpenses.items, id: \.id) { item in
                            if item.type == "Business" {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                            .font(.headline)
                                        
                                        Text(item.type)
                                    }
                                    
                                    Spacer()
                                    
                                    Text(item.amount, format: .currency(code: item.currency))
                                        .colorChange(amount: item.amount)
                                }
                            }
                        }
                        //This modifier only exists for ForEach
                        .onDelete(perform: viewModel.removeBusinessItems(at: <#T##IndexSet#>))
                    }
                }
            }
            .navigationTitle("iExpense")
        }
    }
}

#Preview {
    iExpenseView()
}

