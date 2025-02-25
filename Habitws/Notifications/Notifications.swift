//
//  Notifications.swift
//  Habitws
//
//  Created by matheus vitor on 23/02/25.
//

import Foundation
import UserNotifications

func requestNotificationPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
        if let error = error {
            print("Error ao pedir permissão: \(error.localizedDescription)")
        } else {
            print("Permissão Concedida!")
        }
    }
}

func scheduleNotification(habitTitle: String, period: Habit.TimeOfDay) {
    let content = UNMutableNotificationContent()
    content.title = "Lembrete de Hábito"
    content.body = "Hora do hábito: \(habitTitle)"
    content.sound = .default
    
    var dateComponents = DateComponents()
    
    switch period {
    case .morning:
        dateComponents.hour = 8
        dateComponents.minute = 0
    case .afternoon:
        dateComponents.hour = 14
        dateComponents.minute = 0
    case .night:
        dateComponents.hour = 20
        dateComponents.minute = 0
    case .all:
        dateComponents.hour = 12
        dateComponents.minute = 30
    default:
        break
    }
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            print("Erro ao agendar notificação: \(error.localizedDescription)")
        } else {
            print("Notificação agendada para \(period) às \(dateComponents.hour!):\(String(format: "%02d", dateComponents.minute!))")
        }
    }
}
