//
//  iOS_GrandHotelApp.swift
//  iOS_GrandHotel
//
//  Created by Mohammed on 15/07/2026.
//

import SwiftUI
import ComposableArchitecture

@main
struct iOS_GrandHotelApp: App {

    var body: some Scene {
        
        
        WindowGroup {
            Splash(store: Store(initialState: SplashReducer.State(), reducer: {
                SplashReducer()
            }))
        }
    }
}
