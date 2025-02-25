//
//  MainView.swift
//  Habitws
//
//  Created by matheus vitor on 23/02/25.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Query private var users: [User]
    @State private var isLoading = true
    var body: some View {
        ZStack {
            if isLoading {
                SplashView()
                    .transition(.scale)
            } else {
                if users.isEmpty {
                    StartView()
                        .transition(.scale)
                } else {
                    HomeTabView()
                        .transition(.move(edge: .leading))
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isLoading = false
                }
            }
        }
    }
}

#Preview {
    MainView()
}
