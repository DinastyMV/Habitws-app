//
//  User.swift
//  Habitws
//
//  Created by matheus vitor on 22/02/25.
//

import Foundation
import SwiftData

@Model
class User {
    var name: String
    var birthDate: Date
    
    init(name: String, birthDate: Date) {
        self.name = name
        self.birthDate = birthDate
    }
    
    var age: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: birthDate, to: Date())
        return components.year ?? 0
    }
}
