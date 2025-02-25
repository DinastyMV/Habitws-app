//
//  HomeView.swift
//  Habitws
//
//  Created by matheus vitor on 22/02/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query private var users: [User]
    @Query private var habits: [Habit]
    
    @State private var showCreateHabit: Bool = false
    @State private var showEditView: Bool = false
    
    @State private var habitToEdit: Habit?
    @State private var headerColor: MeshGradient = MeshGradient(
        width: 2, height: 2, points: [
            [0, 0], [1, 0],
            [0, 1], [1, 1]
        ], colors: [
            .black, .gray,
            .gray, .black
        ]
    )
    
    var body: some View {
        NavigationStack {
            VStack {
                header()
                HStack {
                    bodyStepOne()
                    bodyStepTwo()
                }
                .font(.custom("Avenir", size: 18))
                
                List {
                    ForEach(habits.filter { $0.shouldShowToday }) { habit in
                        if habit.timeOfDay == .all {
                            HabitRowView(habit: habit)
                                .swipeActions(edge: .leading) {
                                    Button(action: {
                                        habitToEdit = habit
                                        showEditView = true
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
            .padding()
            .sheet(item: $habitToEdit) { habit in
                EditHabitView(habit: habit)
            }
            .sheet(isPresented: $showCreateHabit) {
                CreateHabitView()
            }
        }
    }
    
    private func header() -> some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(headerColor)
            .stroke(.black, lineWidth: 2)
            .frame(maxWidth: .infinity, maxHeight: 120)
            .overlay {
                HStack {
                    if let user = users.first {
                        Text("Olá, \(user.name)!")
                    } else {
                        Text("Olá!")
                    }
                }
                .font(.custom("Avenir", size: 32))
                .fontWeight(.bold)
                .foregroundStyle(.white)
            }
    }
    
    private func bodyStepOne() -> some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(.clear)
            .stroke(.black, lineWidth: 2)
            .frame(maxWidth: .infinity, maxHeight: 100)
            .overlay {
                Button(action: {
                    showCreateHabit = true
                }) {
                    Text("Criar Hábito")
                        .foregroundStyle(.black)
                        .fontWeight(.semibold)
                }
                
            }
    }
    
    private func bodyStepTwo() -> some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(.clear)
            .stroke(.black, lineWidth: 2)
            .frame(maxWidth: .infinity, maxHeight: 100)
            .overlay {
                NavigationLink("Mostrar Hábitos") {
                    ShowHabits()
                }
                .foregroundStyle(.black)
                .fontWeight(.semibold)
            }
    }
    
    private func deleteHabit(_ habit: Habit) {
        modelContext.delete(habit)
        try? modelContext.save()
    }
}

#Preview {
    HomeView()
}
