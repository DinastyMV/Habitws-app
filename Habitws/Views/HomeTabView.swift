//
//  HomeTabView.swift
//  Habitws
//
//  Created by matheus vitor on 22/02/25.
//

import SwiftUI

struct HomeTabView: View {
    @State private var selectedTab: TabItem = .home
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label(TabItem.home.rawValue, systemImage: TabItem.home.icon)
                }
                .tag(TabItem.home)
            
            MorningView()
                .tabItem {
                    Label(TabItem.morning.rawValue, systemImage: TabItem.morning.icon)
                }
                .tag(TabItem.morning)
            
            AfternoonView()
                .tabItem {
                    Label(TabItem.afternoon.rawValue, systemImage: TabItem.afternoon.icon)
                }
                .tag(TabItem.afternoon)
            
            NightView()
                .tabItem {
                    Label(TabItem.night.rawValue, systemImage: TabItem.night.icon)
                }
                .tag(TabItem.night)
            
//            TestView()
//                .tabItem {
//                    Label(TabItem.test.rawValue, systemImage: TabItem.test.icon)
//                }
//                .tag(TabItem.test)
        }
        .tint(selectedTab.color)
        .tabViewStyle(.automatic)
        .navigationBarBackButtonHidden(true)
    }
}

enum TabItem: String, CaseIterable {
    case home
    case morning
    case afternoon
    case night
    case test
    
    var icon: String {
        switch self {
        case .home:
            return "house"
        case .morning:
            return "sunrise"
        case .afternoon:
            return "sun.max.fill"
        case .night:
            return "moon"
        case .test:
            return "person.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .home: return .purple
        case .morning: return .yellow
        case .afternoon: return .orange
        case .night: return .blue
        case .test: return .red
        }
    }
}

#Preview {
    HomeTabView()
}
