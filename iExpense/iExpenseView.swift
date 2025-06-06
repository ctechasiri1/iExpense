//
//  iExpenseView.swift
//  iExpense
//
//  Created by Chiraphat Techasiri on 6/3/25.
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

struct iExpenseView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [ExpenseItem]
    
    let expenseType: String?
    
    init(expenseType: String?, sortOrder: [SortDescriptor<ExpenseItem>]) {
        self.expenseType = expenseType
        if let expenseType {
            _expenses = Query(
                filter: #Predicate { $0.type == expenseType},
                sort: sortOrder)
        } else {
            _expenses = Query(sort: sortOrder)
        }
    }
    
    var body: some View {
        ForEach(expenses) { expense in
            HStack {
                VStackLayout(alignment: .leading) {
                    Text(expense.name).font(.headline)
                    Text(expense.type)
                }
                Spacer()
                
                Text(expense.amount, format: .currency(code: expense.currency))
                    .colorChange(amount: expense.amount)
            }
        }
    }
}

#Preview {
    iExpenseView(expenseType: "Personal", sortOrder: [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount)
    ]
    )
        .modelContainer(for: ExpenseItem.self)
}
