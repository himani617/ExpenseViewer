//
//  ContentView.swift
//  ExpenseViewer
//
//  Created by HIMANI VARU on 21/08/25.
//

import SwiftUI

struct ContentView: View {
    
    // State Objects
    @StateObject private var viewModel = ExpenseViewModel()
    @StateObject private var reachability = Reachability()

    var body: some View {
        
        // Navigation & Main UI
        NavigationStack {
            Group {
                // Content States
                if viewModel.isLoading {
                    ProgressView("Loading…")
                }
                // Error State
                else if let err = viewModel.errorMessage {
                    VStack(spacing: 12) {
                        Text("Failed to load").font(.headline)
                        Text(err).foregroundStyle(.secondary).multilineTextAlignment(.center)
                        Button("Retry") { viewModel.load() }
                    }.padding()
                }
                // Empty State
                else if viewModel.expenses.isEmpty {
                    ContentUnavailableView("No expenses", systemImage: "tray")
                }
                // Success State (Expenses Available)
                else {
                    List(viewModel.expenses) { exp in
                        ExpenseRow(expense: exp)
                    }
                    .listStyle(.insetGrouped)
                    .refreshable { viewModel.load() }
                }
            }
            .navigationTitle("💸 Expenses")
            // Toolbar (Refresh Button)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.load()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
            
            // Offline Banner
            .overlay(alignment: .bottom) {
                if !reachability.isOnline {
                    HStack(spacing: 8) {
                        Image(systemName: "wifi.exclamationmark")
                        Text("You’re offline")
                    }
                    .padding(.horizontal, 14).padding(.vertical, 8)
                    .background(.thinMaterial)
                    .clipShape(Capsule())
                    .padding(.bottom, 12)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            
        }
        // Lifecycle Hook
        .onAppear { viewModel.load() }
    }
}




