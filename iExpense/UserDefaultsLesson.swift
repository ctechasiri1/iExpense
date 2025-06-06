//
//  UserDefaults.swift
//  iExpense
//
//  Created by Chiraphat Techasiri on 10/21/24.
//

import SwiftUI

struct UserDefaultsLesson: View {
    
    @AppStorage("tapCount") private var tapCount = 0
    
    var body: some View {
        Button("Tap Count: \(tapCount)") {
            tapCount += 1
        }
    }
}

#Preview {
    UserDefaultsLesson()
}
