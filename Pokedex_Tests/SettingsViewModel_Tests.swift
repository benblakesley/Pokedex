//
//  SettingsViewModel_Tests.swift
//  Pokedex_Tests
//
//  Created by Ben Blakesley on 22/10/2024.
//

import XCTest
@testable import Pokedex

final class SettingsViewModel_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    override func setUp() {
           super.setUp()
           // Clear UserDefaults before each test
           UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
           UserDefaults.standard.synchronize()
    }
    
    func test_SettingsViewModel_init_defaultLight()
    {
        let settingsViewModel = SettingsViewModel()
        
        XCTAssertTrue(settingsViewModel.settings.colorScheme == ColorSchemePreference.light)
    }
    
    func test_SettingsViewModel_toggleFromLightToDark()
    {
        let settingsViewModel = SettingsViewModel()
        
        settingsViewModel.settings.colorScheme = .light
        
        settingsViewModel.toggleColorScheme()
        
        let settingsData = settingsViewModel.settingsData
        
        let settingsDataParsed = try? JSONDecoder().decode(SettingsModel.self, from: settingsData)
        
        XCTAssertEqual(settingsDataParsed?.colorScheme, .dark)
        XCTAssertEqual(settingsViewModel.settings.colorScheme, .dark)
    }
    
    func test_SettingsViewModel_toggleFromDarkToLight()
    {
        let settingsViewModel = SettingsViewModel()
        
        settingsViewModel.settings.colorScheme = .dark
        
        settingsViewModel.toggleColorScheme()
        
        let settingsData = settingsViewModel.settingsData
        
        let settingsDataParsed = try? JSONDecoder().decode(SettingsModel.self, from: settingsData)
        
        XCTAssertEqual(settingsDataParsed?.colorScheme, .light)
        XCTAssertEqual(settingsViewModel.settings.colorScheme, .light)
    }
    
    func test_SettingsViewModel_init_getInitFromUserDefaults()
    {
        let model = SettingsModel(colorScheme: .dark)
        let data = try? JSONEncoder().encode(model)
        UserDefaults.standard.set(data, forKey: "colorScheme")
        
        let viewModel = SettingsViewModel()

        XCTAssertEqual(viewModel.settings.colorScheme, .dark)
    }
}
