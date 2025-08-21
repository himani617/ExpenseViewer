
//
//  ExpenseViewModel.swift
//  ExpenseViewer
//
//  Created by HIMANI VARU on 21/08/25.
//

import Foundation
import Combine

@MainActor
final class ExpenseViewModel: ObservableObject {
    @Published var expenses: [Expense] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let fetcher = ExpenseFetcher() //Call Objective-C fetcher.
    private let endpoint = "https://www.jsonkeeper.com/b/DYZJF"

    func load() {
        isLoading = true
        errorMessage = nil

        fetcher.fetchExpenses(withURLString: endpoint) { [weak self] items, error in
            Task { @MainActor in
                guard let self = self else { return }
                self.isLoading = false

                if error != nil {
                    self.errorMessage = error?.localizedDescription
                    return
                }

                // Convert each element into [String: Any] before parsing.
                let mapped: [Expense] = (items ?? []).compactMap { raw -> Expense? in
                    if let dict = raw as? [String: Any] {
                        return Expense(dict: dict)
                    } else if let ahDict = raw as? [String: Any] {
                        var stringDict = [String: Any]()
                        for (key, value) in ahDict {
                            if let k = key as? String {
                                stringDict[k] = value
                            } else {
                                stringDict["\(key)"] = value
                            }
                        }
                        return Expense(dict: stringDict)
                    } else {
                        return nil
                    }
                }

                // Sort newest first
                self.expenses = mapped.sorted(by: { $0.date > $1.date })
            }
        }
    }
}
