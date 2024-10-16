//
//  StatColors.swift
//  Pokedex
//
//  Created by Ben Blakesley on 14/10/2024.
//

import Foundation
import SwiftUI

let statColors: [StatCategory: Color] =
[
    .awful: Color(red: 178/255, green: 34/255, blue: 34/255),  // #B22222
    .bad: Color(red: 1.0, green: 165/255, blue: 0),             // #FFA500
    .average: Color(red: 1.0, green: 1.0, blue: 0),             // #FFFF00
    .good: Color(red: 144/255, green: 238/255, blue: 144/255), // #90EE90
    .great: Color(red: 0, green: 127/255, blue: 255/255)       // #007FFF
]

enum StatCategory: String {
    case awful = "Awful"
    case bad = "Bad"
    case average = "Average"
    case good = "Good"
    case great = "Great"

    static func category(for value: Int) -> StatCategory {
        switch value {
        case 0...30:
            return .awful
        case 31...60:
            return .bad
        case 61...90:
            return .average
        case 91...120:
            return .good
        case 121...250:
            return .great
        default:
            return .awful // Default case if value is out of range
        }
    }
}
