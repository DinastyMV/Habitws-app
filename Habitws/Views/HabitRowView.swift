//
//  HabitRowView.swift
//  Habitws
//
//  Created by matheus vitor on 23/02/25.
//

import SwiftUI

struct HabitRowView: View {
    @Bindable var habit: Habit
    var body: some View {
        HStack {
            Text(habit.title)
                .font(.custom("Avenir", size: 24))
                .fontWeight(.semibold)
            Spacer()
            Image(systemName: "xmark")
                 .foregroundStyle(habit.status == .skipped ? .yellow : .gray)
                 .padding(.trailing)
            Image(systemName: "checkmark")
                .foregroundStyle(habit.status == .completed ? .green : .gray)
                
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var habit = Habit(
        id: UUID(),
        title: "Teste"
    )
    HabitRowView(habit: habit)
}
