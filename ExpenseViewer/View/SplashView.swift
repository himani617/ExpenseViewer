
//
//  SplashView.swift
//  ExpenseViewer
//
//  Created by HIMANI VARU on 21/08/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        
        // ZStack – Layered Layout
        ZStack {
            LinearGradient(colors: [.blue, .purple],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)    // Gradient background.
                .ignoresSafeArea()

            // VStack – Content Layout
            VStack(spacing: 16) {
                Image(systemName: "creditcard.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .accessibilityIdentifier("splashIcon")

                // App Title
                Text("Expense Viewer")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .accessibilityIdentifier("splashTitle")
            }
        }
    }
}
