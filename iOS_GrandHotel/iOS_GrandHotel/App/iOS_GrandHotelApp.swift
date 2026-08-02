//
//  iOS_GrandHotelApp.swift
//  iOS_GrandHotel
//
//  Created by Mohammed on 15/07/2026.
//

import SwiftUI
import SwiftData
import ComposableArchitecture
import FirebaseCore

@main
struct iOS_GrandHotelApp: App {
    
    class AppDelegate: NSObject, UIApplicationDelegate {
      func application(_ application: UIApplication,
                       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
      }
    }

    private let modelContainer: ModelContainer

    init() {
        do {
            modelContainer = try ModelContainer(for: OnboardingSlide.self, AppState.self)
        } catch {
            fatalError("Unable to create the SwiftData container: \(error)")
        }
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        
        WindowGroup {
            AppEntryView()
        }
        .modelContainer(modelContainer)
    }
}

private struct AppEntryView: View {
    @State private var isShowingSplash = true

    var body: some View {
        Group {
            if isShowingSplash {
                Splash(store: Store(initialState: SplashReducer.State(), reducer: {
                    SplashReducer()
                }))
                .task {
                    try? await Task.sleep(for: .seconds(2))
                    guard !Task.isCancelled else { return }
                    withAnimation(.easeOut(duration: 0.25)) {
                        isShowingSplash = false
                    }
                }
            } else {
                OnboardingRootView()
            }
        }
    }
}
