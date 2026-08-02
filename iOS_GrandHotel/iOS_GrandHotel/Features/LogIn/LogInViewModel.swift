//
//  LogInViewModel.swift
//  iOS_GrandHotel
//
//  Created by Mohammed on 01/08/2026.
//

import Foundation
import SwiftUI
import FirebaseAuth



@MainActor
final class LogInViewModel: ObservableObject {

    @Published var email = ""
    @Published var password = ""
    @Published var isLoggedIn = false
    @Published var errorMessage: String?
    @Published var isLoading = false

    func isLoggedBefore() -> Bool {
        print(Auth.auth().currentUser!)
       return Auth.auth().currentUser != nil
    }

    func login() async {

        isLoading = true
        errorMessage = nil

        do {
            let result = try await Auth.auth().signIn(
                withEmail: email,
                password: password
            )

            print(result.user.uid)

            isLoggedIn = true

        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
