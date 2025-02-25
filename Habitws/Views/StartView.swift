//
//  StartView.swift
//  Habitws
//
//  Created by matheus vitor on 22/02/25.
//

import SwiftUI
import SwiftData

struct StartView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]
    
    @State var name: String = ""
    @State var birthDay: Date = Date()
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack {
                    
                    Text("Habitws")
                        .font(.custom("Avenir", size: 48))
                    
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.clear)
                        .stroke(.black, lineWidth: 2)
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .overlay {
                            VStack(alignment: .leading) {
                                Text("Digite seu nome")
                                    .fontWeight(.semibold)
                                
                                TextField("Ex. João Da Silva", text: $name)
                                    .textFieldStyle(.plain)
                                
                                Divider()
                                
                                DatePicker("Selecione sua data de nascimento", selection: $birthDay, displayedComponents: .date)
                                    .fontWeight(.semibold)
                                
                            }
                            .font(.custom("Avenir", size: 18))
                            .padding()
                        }
                    
                    NavigationLink(destination: HomeTabView()) {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.clear)
                            .stroke(.black, lineWidth: 2)
                            .frame(maxWidth: .infinity, maxHeight: 60)
                            .overlay {
                                HStack {
                                    Text("Avançar")
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                    
                                }
                                .font(.custom("Avenir", size: 18))
                                .foregroundStyle(.black)
                                .padding()
                            }
                        
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        saveUser()
                    })
                    
                    Spacer()
                }
                .padding()
            }
            .onAppear {
                loadUser()
                requestNotificationPermission()
            }
        }
    }
    
    private func saveUser() {
        if let user = users.first {
            user.name = name
            user.birthDate = birthDay
        } else {
            let newUser = User(name: name, birthDate: birthDay)
            modelContext.insert(newUser)
        }
        
        try? modelContext.save()
    }
    
    private func loadUser() {
        if let user = users.first {
            name = user.name
            birthDay = user.birthDate
        }
    }
}

#Preview {
    StartView()
}
