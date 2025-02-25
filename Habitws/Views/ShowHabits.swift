//
//  ShowHabits.swift
//  Habitws
//
//  Created by matheus vitor on 23/02/25.
//

import SwiftUI
import SwiftData

struct ShowHabits: View {
    @Environment(\.modelContext) var modelContext
    
    @Query private var habits: [Habit]
    
    @State private var habitToEdit: Habit?
    @State private var showingEditView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(habits) { habit in
                        HabitRowView(habit: habit)
                            .swipeActions(edge: .trailing) {
                                Button(action: {
                                    habitToEdit = habit
                                    showingEditView = true
                                }) {
                                    Label("Editar", systemImage: "pencil")
                                }
                                .tint(.blue)
                            }
                            .swipeActions(edge: .leading) {
                                Button(role: .destructive) {
                                    deleteHabit(habit)
                                } label: {
                                    Label("Excluir", systemImage: "trash")
                                }
                                .tint(.red)
                            }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle(Text("Hábitos"))
        }
    }
    
    private func deleteHabit(_ habit: Habit) {
        modelContext.delete(habit)
        try? modelContext.save()
    }
}

#Preview {
    ShowHabits()
}
