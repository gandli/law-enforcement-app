//
//  LeadSightApp.swift
//  LeadSight
//
//  Created by user on 2026/3/1.
//

import SwiftUI

@main
struct LeadSightApp: App {
    @State private var dataStore = DataStore()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(dataStore)
        }
    }
}
