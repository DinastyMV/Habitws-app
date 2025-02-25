//
//  MorningView.swift
//  Habitws
//
//  Created by matheus vitor on 22/02/25.
//

import SwiftUI
import SwiftData

struct MorningView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query private var users: [User]
    @Query private var habits: [Habit]
    
    @State private var habitToEdit: Habit?
    @State private var showingEditView: Bool = false
    @State private var headerColor: MeshGradient = MeshGradient(
        width: 2, height: 2, points: [
            [0, 0], [1, 0],
            [0, 1], [1, 1]
        ], colors: [
            .yellow, .blue,
            .orange, .yellow
        ]
    )
    
    var body: some View {
        VStack {
            headerMorningView()
            
            List {
                ForEach(habits.filter { $0.shouldShowToday }) { habit in
                    if habit.timeOfDay == .morning {
                        HabitRowView(habit: habit)
                            .swipeActions(edge: .leading) {
                                Button(action: {
                                    habitToEdit = habit
                                    showingEditView = true
                                }) {
                                    Label("Editar", systemImage: "pencil")
                                }
                                .tint(.blue)
                                
                                Button(role: .destructive) {
                                    deleteHabit(habit)
                                } label: {
                                    Label("Excluir", systemImage: "trash")
                                }
                                .tint(.red)
                            }
                            .swipeActions(edge: .trailing) {
                                Button("Completar") { habit.complete() }
                                    .tint(.green)
                                Button("Pular") { habit.skip() }
                                    .tint(.yellow)
                            }
                    }
                }
            }
            .listStyle(.plain)
            
        }
        .edgesIgnoringSafeArea(.all)
        .padding()
        .sheet(item: $habitToEdit) { habit in
            EditHabitView(habit: habit)
        }
        
    }
    
    private func headerMorningView() -> some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(headerColor)
            .stroke(.black, lineWidth: 2)
            .frame(maxWidth: .infinity, maxHeight: 120)
            .overlay {
                HStack {
                    if let user = users.first {
                        Text("Bom dia, \(user.name)!")
                    } else {
                        Text("Bom dia!")
                    }
                }
                .font(.custom("Avenir", size: 32))
                .fontWeight(.bold)
                .foregroundStyle(.white)
            }
    }
    
    private func deleteHabit(_ habit: Habit) {
        modelContext.delete(habit)
        try? modelContext.save()
    }
}

#Preview {
    MorningView()
}
