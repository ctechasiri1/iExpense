//
//  ClassAndStructs.swift
//  iExpense
//
//  Created by Chiraphat Techasiri on 10/21/24.
//
import Observation
import SwiftUI

/* is similar to @State but for classes where classes are pointed to
 by many different things while structs are usually pointed to by one thing like a chain
 */
@Observable
class User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

struct ClassAndStructs: View {
    
    @State private var user = User()
    
    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName)")

            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
        .padding()
    }
}

#Preview {
    ClassAndStructs()
}
