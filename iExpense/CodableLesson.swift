//
//  CodableLesson.swift
//  iExpense
//
//  Created by Chiraphat Techasiri on 10/21/24.
//

import SwiftUI

struct User2: Codable {
    let firstname: String
    let lastname: String
}

struct CodableLesson: View {
    @State private var user = User2(firstname: "Taylor", lastname: "Swift")
    
    var body: some View {
        Button("Save User") {
            let encoder = JSONEncoder()
            
            if let data = try? encoder.encode(user) {
                UserDefaults.standard.setValue(data, forKey: "UserData")
            }
        }
    }
}

#Preview {
    CodableLesson()
}
