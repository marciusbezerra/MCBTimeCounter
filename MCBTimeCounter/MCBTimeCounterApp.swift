//
//  MCBTimeCounterApp.swift
//  MCBTimeCounter
//
//  Created by Marcius Bezerra on 02/06/23.
//

import SwiftUI

@main
struct MCBTimeCounterApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView(appDelegate: appDelegate)
        }
    }
}
