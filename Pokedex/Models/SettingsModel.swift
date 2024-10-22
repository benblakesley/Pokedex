//
//  SettingsModel.swift
//  Pokedex
//
//  Created by Ben Blakesley on 22/10/2024.
//

import Foundation
import SwiftUI

enum ColorSchemePreference: String, Codable {
    case light
    case dark
}

let colorSchemeMap: [ColorSchemePreference: ColorScheme] =
[
    .dark : .dark,
    .light: .light
]

struct SettingsModel: Codable
{
    var colorScheme: ColorSchemePreference
}
