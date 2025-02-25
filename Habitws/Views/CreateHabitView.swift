//
//  createHabitView.swift
//  Habitws
//
//  Created by matheus vitor on 23/02/25.
//

import SwiftUI
import SwiftData

struct CreateHabitView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var frequency: Habit.Frequency = .daily
    @State private var customDays = Set<Habit.Weekday>()
    @State private var timeOfDay: Habit.TimeOfDay = .all
    @State private var showDaysPicker: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Detalhes Básicos")) {
                    TextField("Título do hábito", text: $title)
                    
                    Picker("Horário", selection: $timeOfDay) {
                        ForEach(Habit.TimeOfDay.allCases, id: \.self) { time in
                            Text(time.rawValue).tag(time)
                        }
                    }
                }
                
                Section(header: Text("Frequência")) {
                    Picker("Repetição", selection: $frequency) {
                        ForEach(Habit.Frequency.allCases, id: \.self) { frequency in
                            Text(frequency.displayName).tag(frequency)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                if frequency == .custom {
                    Section(header: Text("Selecione os dias")) {
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 4), spacing: 10) {
                            ForEach(Habit.Weekday.allCases, id: \.self) { day in
                                Button(action: {
                                    toggleDay(day)
                                }) {
                                    Text(day.rawValue)
                                        .frame(maxWidth: .infinity)
                                        .padding(8)
                                        .background(customDays.contains(day) ? .blue : .gray.opacity(0.2))
                                        .foregroundStyle(customDays.contains(day) ? .white : .primary)
                                        .cornerRadius(8)
                                        .contentShape(Rectangle())
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .transition(.opacity)
                }
                Section {
                    Button(action: {
                        saveHabit()
                        scheduleNotification(habitTitle: title, period: timeOfDay)
                    }) {
                        HStack {
                            Spacer()
                            Text("Salvar Hábito")
                            Spacer()
                        }
                    }
                }
                .disabled(title.isEmpty)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancelar") {
                    dismiss()
                }
            }
        }
    }
    
    private func toggleDay(_ day: Habit.Weekday) {
        if customDays.contains(day) {
            customDays.remove(day)
        } else {
            customDays.insert(day)
        }
    }
    
    private func saveHabit() {
        let newHabit = Habit(
            title: title,
            frequency: frequency,
            customDays: Array(customDays),
            timeOfDay: timeOfDay
        )
        
        modelContext.insert(newHabit)
        dismiss()
    }
}

#Preview {
    CreateHabitView()
}
