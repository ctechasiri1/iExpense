//
//  ContentView.swift
//  iExpense
//
//  Created by Chiraphat Techasiri on 10/22/24.
//

import SwiftUI

/* 
 -Identifiable means the struct conforms to a protocol, where an id
 is included as once of the variables and in this case it's UUID
 -Codable means the struct conforma to a protocol, where it's id can
 be decoded and encoded
 */
struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    let currency: String
}

/*
 -Observable lets us observe any changes in the class, this is similar to State
 for structs
 -didSet portion executes when items is modified (so when something is added or
 deleted from the array), this is what didSet does
    -then it would encode (capture) the data and can call it using items and it's
     reference key is "Items" (assuming this key is used for decoding)
 -if let portion attempts to call the data from items
    -if the decoding if successful then it will store the data in the items array,
     otherwise an empty array will be returned
 -if let unwrap an optional which is the items array which might or might not have
    data
 -try? will throw an error if the data can't be unwrapped
 */
@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            // stores the data
            if let encoded = try? JSONEncoder().encode(items) {
                // UserDefaults is where data is stored and can be referenced by its key
                UserDefaults.standard.set(encoded, forKey: storageKey)
            }
        }
    }
    
    // able to create different places to store the data by making it dynamic
    private let storageKey: String
    init(storageKey: String) {
        self.storageKey = storageKey
        // calls the stored data
        if let savedItems = UserDefaults.standard.data(forKey: storageKey) {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}

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
    @State private var personalExpenses = Expenses(storageKey: "PersonalItems")
    @State private var businessExpenses = Expenses(storageKey: "BusinessItems")
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Add Expense") {
                    AddView(personalExpenses: personalExpenses, businessExpenses: businessExpenses)
                }
                if !personalExpenses.items.isEmpty {
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
                        .onDelete(perform: removePersonalItems)
                    }
                }
                
                if !businessExpenses.items.isEmpty {
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
                        .onDelete(perform: removeBusinessItems)
                    }
                }
            }
            .navigationTitle("iExpense")
//            .toolbar {
//                Button("Add Expense", systemImage: "plus") {
//                    showingAddExpense = true
//                }
//            }
//            .sheet(isPresented: $showingAddExpense, content: {
//                //this calls the AddView Swift view
//                AddView(personalExpenses: personalExpenses, businessExpenses: businessExpenses)
//            })
        }
    }
    // IndexSet is a collection of integer indices representing positions in an array
    func removePersonalItems(at offsets: IndexSet) {
        //atOffsets deletes items in array by their indices
        personalExpenses.items.remove(atOffsets: offsets)
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        //atOffsets deletes items in array by their indices
        businessExpenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    iExpenseView()
}

