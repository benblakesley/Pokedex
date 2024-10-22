//
//  SettingsViewModel.swift
//  Pokedex
//
//  Created by Ben Blakesley on 22/10/2024.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject
{
    @AppStorage("colorScheme") private var settingsData: Data = Data()
    
    //give a default color scheme of light
    @Published var settings: SettingsModel = SettingsModel(colorScheme: .light)
    
    init() {
        // Load settings when the ViewModel is initialized
        if let settings = try? JSONDecoder().decode(SettingsModel.self, from: settingsData) {
               self.settings = settings
           } else {
               // Set default settings if no data exists
               self.settings = SettingsModel(colorScheme: ColorSchemePreference.light)
           }
    }
    
    public func toggleColorScheme()
    {
        // if color scheme is dark toggle it to light, otherwise toggle it to dark
        settings.colorScheme = settings.colorScheme == .dark ? .light : .dark
        
        // save the new settings
        saveSettingsData()
    }
    
    private func saveSettingsData()
    {
        if let data = try? JSONEncoder().encode(settings) {
            settingsData = data
        }
    }
}
