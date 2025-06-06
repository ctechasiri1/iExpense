//
//  ShowingAndHidingViews.swift
//  iExpense
//
//  Created by Chiraphat Techasiri on 10/21/24.
//

import SwiftUI

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    let name: String
    
    var body: some View {
        Button("Dismiss") {
            dismiss()
        }
    }
}


struct ShowingAndHidingViews: View {
    
    @State private var showingSheet = false
    
    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet, content: {
            SecondView(name: "@c.techasiri")
        })
    }
}

#Preview {
    ShowingAndHidingViews()
}
