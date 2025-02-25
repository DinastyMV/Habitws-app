//
//  SplashView.swift
//  Habitws
//
//  Created by matheus vitor on 22/02/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            MeshGradient(
                width: 3, height: 3, points: [
                    [0, 0], [0.5, 0], [1, 0],
                    [0, 0.5], [0.3, 0.5], [1, 0.5],
                    [0, 1], [0.5, 1], [1, 1]
                ], colors: [
                    .gray, .orange, .yellow,
                    .orange, .yellow, .gray,
                    .gray, .orange, .yellow
                ])
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Bem-vindo ao Habitws")
                    .font(.custom("Avenir", size: 30))
                    .fontWeight(.semibold)
                    .fontDesign(.serif)
                
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(2)
            }
        }
    }
}

#Preview {
    SplashView()
}
