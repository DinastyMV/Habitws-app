//
//  EditHabitView.swift
//  Habitws
//
//  Created by matheus vitor on 23/02/25.
//

import SwiftUI

struct EditHabitView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var habit: Habit
    var body: some View {
        NavigationStack {
            Form {
                TextField("Título do hábito", text: $habit.title)
                Picker(selection: $habit.timeOfDay, label: Text("Momento do Dia")) {
                    Text("Manhã").tag("Morning")
                    Text("Tarde").tag("Afternoon")
                    Text("Noite").tag("Night")
                    Text("Dia Inteiro").tag("All")
                }
            }
            .navigationTitle("Editar Hábito")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Concluir") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var habit = Habit(
        id: UUID(),
        title: "Teste"
    )
    EditHabitView(habit: habit)
}
