//
//  SandboxApp.swift
//  Sandbox
//
//  Created by David Michaels on 8/3/25.
//

import SwiftUI

@main
struct SandboxApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Settings())
        }
    }
}
