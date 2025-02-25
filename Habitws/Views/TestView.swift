//
//  TestView.swift
//  Habitws
//
//  Created by matheus vitor on 23/02/25.
//

import SwiftUI
import SwiftData

struct TestView: View {
    @Query private var users: [User]
    var body: some View {
        List(users) { user in
            Text("\(user.name)")
            Text("\(user.age)")
        }
    }
}

#Preview {
    TestView()
}
