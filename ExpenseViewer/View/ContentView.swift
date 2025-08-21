//
//  ContentView.swift
//  ExpenseViewer
//
//  Created by HIMANI VARU on 21/08/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ExpenseViewModel()
    @StateObject private var reachability = Reachability()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading…")
                } else if let err = viewModel.errorMessage {
                    VStack(spacing: 12) {
                        Text("Failed to load").font(.headline)
                        Text(err).foregroundStyle(.secondary).multilineTextAlignment(.center)
                        Button("Retry") { viewModel.load() }
                    }.padding()
                } else if viewModel.expenses.isEmpty {
                    ContentUnavailableView("No expenses", systemImage: "tray")
                } else {
                    List(viewModel.expenses) { exp in
                        ExpenseRow(expense: exp)
                    }
                    .listStyle(.insetGrouped)
                    .refreshable { viewModel.load() }
                }
            }
            .navigationTitle("💸 Expenses")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.load()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
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
        .onAppear { viewModel.load() }
    }
}




