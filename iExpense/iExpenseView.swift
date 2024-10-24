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
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        // calls the stored data
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}

struct iExpenseView: View {
    
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items, id: \.id) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            
                            Text(item.type)
                        }
                        
                        Spacer()
                        
                        Text(item.amount, format: .currency(code: "USD"))
                    }
                }
                //This modifier only exists for ForEach
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true

                }
            }
            .sheet(isPresented: $showingAddExpense, content: {
                //this calls the AddView Swift view
                AddView(expenses: expenses)
            })
        }
    }
    // IndexSet is a collection of integer indices representing positions in an array
    func removeItems(at offsets: IndexSet) {
        //atOffsets deletes items in array by their indices
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    iExpenseView()
}

