//
//  ExpenseViewerApp.swift
//  ExpenseViewer
//
//  Created by HIMANI VARU on 21/08/25.
//

// This is the entry point of the app.

import SwiftUI

@main
struct ExpenseViewerApp: App {
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashView()  // Shows SplashView for 2 seconds.
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(.easeOut(duration: 0.5)) {
                                showSplash = false
                            }
                        }
                    }
            } else {
                ContentView()
            }
        }
    }
}

