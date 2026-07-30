//
//  OnboardingRootView.swift
//  iOS_GrandHotel
//

import SwiftUI
import SwiftData

struct OnboardingRootView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var appStates: [AppState]
    @Query(sort: \OnboardingSlide.order) private var slides: [OnboardingSlide]
    @State private var hasFinishedPreparing = false

    var body: some View {
        Group {
            if hasFinishedPreparing, let appState = appStates.first {
                if appState.hasCompletedOnboarding || slides.isEmpty {
                    HomeView(appState: appState)
                } else {
                    WalkthroughView(appState: appState)
                }
            } else {
                ProgressView()
            }
        }
        .task {
            seedDatabaseIfNeeded()
            hasFinishedPreparing = true
        }
    }

    private func seedDatabaseIfNeeded() {
        if appStates.isEmpty {
            modelContext.insert(AppState())
            modelContext.insert(OnboardingSlide(title: "Stay in Style", details: "Find a hotel that feels just right, wherever your journey takes you.", image: Image.onboardingImageData(for: 0), order: 0))
            modelContext.insert(OnboardingSlide(title: "Comfort Comes First", details: "Enjoy thoughtful details and a stay designed around you.", image: Image.onboardingImageData(for: 1), order: 1))
            modelContext.insert(OnboardingSlide(title: "Your Stay, Simplified", details: "Everything you need for an effortless check-in and a memorable stay.", image: Image.onboardingImageData(for: 2), order: 2))
        }

        for slide in slides where slide.image == nil {
            slide.image = Image.onboardingImageData(for: slide.order)
        }

        try? modelContext.save()
    }
}

#Preview {
    OnboardingRootView()
        .modelContainer(for: [OnboardingSlide.self, AppState.self], inMemory: true)
}
