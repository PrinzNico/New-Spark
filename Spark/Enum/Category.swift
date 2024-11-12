//
//  Category.swift
//  Spark
//
//  Created by Nico Prinz on 11.11.24.
//

import Foundation
import SwiftData

enum Category: String, Identifiable, CaseIterable, Codable {
    
    case erfolg = "Motivation & Erfolg"
    case mut = "Mut & Durchhaltevermögen"
    case zeit = "Vergänglichkeit & Zeit"
    case zufriedenheit = "Glück & Zufriedenheit"
    case freiheit = "Freiheit & Selbstbestimmung"
    
    var id: String { rawValue }
}
