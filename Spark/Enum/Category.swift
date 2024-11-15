//
//  Category.swift
//  Spark
//
//  Created by Nico Prinz on 11.11.24.
//
//MARK: - Hier erstellen wir ein Enum das uns die Category bestimmen lassen können wenn wir das Enum richtig coden: String, CaseIterable, Codeable. eine ID variable für das rawValue um aus der DatenBank wieder darauf zugreifen zu können.

import Foundation
import SwiftData
///Hier bestimmen wir die Kategorie
enum Category: String, Identifiable, CaseIterable, Codable {
    case erfolg = "Motivation & Erfolg"
    case mut = "Mut & Durchhaltevermögen"
    case zeit = "Vergänglichkeit & Zeit"
    case zufriedenheit = "Glück & Zufriedenheit"
    case freiheit = "Freiheit & Selbstbestimmung"
    
    var id: String { rawValue }
}



