//
//  SearchViewModel.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 01.11.24.
//

import Foundation
import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var users: [UserPreview] = []
    @Published var isLoading = false
    @Published var errorLoading = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        setupBindings()
    }

    private func setupBindings() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] newValue in
                if !newValue.isEmpty {
                    self?.fetchUsers(loginPrefix: newValue)
                } else {
                    self?.users = []
                }
            }
            .store(in: &cancellables)
    }

    func fetchUsers(loginPrefix: String) {
        isLoading = true
        errorLoading = false

        APIClient.shared.fetchUsers(prefix: loginPrefix) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let fetchedUsers):
                    self?.users = fetchedUsers
                case .failure:
                    self?.errorLoading = true
                }
            }
        }
    }
}
