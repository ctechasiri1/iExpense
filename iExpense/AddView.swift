//
//  AddView.swift
//  iExpense
//
//  Created by Chiraphat Techasiri on 10/22/24.
//

import SwiftUI

//This creates a new screen view
struct AddView: View {
    //This creates a dismiss action
    @Environment(\.dismiss) var dismiss
    
    @State private var name = "Add Expense"
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State var selectedCurrency = ""
    
    var personalExpenses: Expenses
    var businessExpenses: Expenses
    
    let types = ["Business", "Personal"]
    let currencies = ["USD", "EUR", "GBP", "JPY", "CAD"]
    
    var body: some View {
        NavigationStack {
            Form {
//                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                Picker("Currency", selection: $selectedCurrency) {
                    ForEach(currencies, id: \.self) { currency in
                        Text("\(currency)")
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: selectedCurrency))
                    .keyboardType(.decimalPad)
                
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
//            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount, currency: selectedCurrency)
                    if item.type == "Personal" {
                        personalExpenses.items.append(item)
                    } else {
                        businessExpenses.items.append(item)
                    }
                    dismiss()
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    dismissView()
                }
            }
        }
    }
}

#Preview {
    AddView(personalExpenses: Expenses(storageKey: "PersonalItems"), businessExpenses: Expenses(storageKey: "BusinessItems"))
}
