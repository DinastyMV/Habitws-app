//
//  Habits.swift
//  Habitws
//
//  Created by matheus vitor on 23/02/25.
//

import Foundation
import SwiftData

@Model
class Habit {
    enum Frequency: String, Codable, CaseIterable {
        case daily, weekly, monthly, custom
        
        var displayName: String {
            switch self {
            case .daily: return "Diário"
            case .weekly: return "Semanal"
            case .monthly: return "Mensal"
            case .custom: return "Personalizado"
            }
        }
    }

    enum Weekday: String, Codable, CaseIterable {
        case sunday = "Dom", monday = "Seg", tuesday = "Ter", wednesday = "Qua",
             thursday = "Qui", friday = "Sex", saturday = "Sáb"
        
        var symbol: String {
            switch self {
            case .sunday: return "🌞"
            case .monday: return "📅"
            case .tuesday: return "📚"
            case .wednesday: return "🏋️"
            case .thursday: return "💧"
            case .friday: return "🎉"
            case .saturday: return "🛌"
            }
        }
    }

    enum Status: Int, Codable {
        case pending, completed, skipped
    }

    enum TimeOfDay: String, Codable, CaseIterable {
        case all = "Qualquer hora"
        case morning = "Manhã"
        case afternoon = "Tarde"
        case night = "Noite"
    }

    // MARK: - Properties
    @Attribute(.unique) var id: UUID
    var title: String
    var createdAt: Date
    var lastCompletedAt: Date?
    var frequency: Frequency
    var customDays: [Weekday]
    var status: Status
    var timeOfDay: TimeOfDay
    var isActive: Bool
    
    // MARK: - Initializer
    init(
        id: UUID = UUID(),
        title: String,
        createdAt: Date = Date(),
        frequency: Frequency = .daily,
        customDays: [Weekday] = [],
        timeOfDay: TimeOfDay = .all,
        isActive: Bool = true
    ) {
        self.id = id
        self.title = title
        self.createdAt = createdAt
        self.frequency = frequency
        self.customDays = customDays
        self.status = .pending
        self.timeOfDay = timeOfDay
        self.isActive = isActive
    }
    
    // MARK: - Business Logic
    var shouldShowToday: Bool {
        guard isActive else { return false }
        
        let calendar = Calendar.current
        let today = Date()
        
        guard let lastDate = lastCompletedAt else { return true }
        
        switch frequency {
        case .daily:
            return !calendar.isDate(lastDate, inSameDayAs: today)
            
        case .weekly:
            let daysSinceLast = calendar.dateComponents([.day], from: lastDate, to: today).day ?? 0
            return daysSinceLast >= 7
            
        case .monthly:
            guard let nextMonth = calendar.date(byAdding: .month, value: 1, to: lastDate) else { return false }
            return today >= nextMonth
            
        case .custom:
            let currentWeekday = Weekday.allCases[calendar.component(.weekday, from: today) - 1]
            return customDays.contains(currentWeekday)
        }
    }
    
    func complete() {
        status = .completed
        lastCompletedAt = Date()
    }
    
    func skip() {
        status = .skipped
        lastCompletedAt = Date()
    }
    
    func reset() {
        status = .pending
        lastCompletedAt = nil
    }
}

// MARK: - Helper Extensions
extension Habit {
    static var timeOfDayOptions: [TimeOfDay] { TimeOfDay.allCases }
    static var frequencyOptions: [Frequency] { Frequency.allCases }
    static var weekdayOptions: [Weekday] { Weekday.allCases }
}

extension Calendar {
    func weekdaySymbol(from date: Date) -> String {
        let weekdayIndex = component(.weekday, from: date) - 1
        return Habit.Weekday.allCases[weekdayIndex].rawValue
    }
}
