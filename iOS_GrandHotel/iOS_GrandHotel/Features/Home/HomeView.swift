//
//  HomeView.swift
//  iOS_GrandHotel
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    let appState: AppState

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Welcome!")
                    .font(.largeTitle.bold())

                NavigationLink("Manage Slides") {
                    ManageSlidesView()
                }
                .buttonStyle(.borderedProminent)

                Button("Replay Onboarding", action: replayOnboarding)
                    .buttonStyle(.bordered)
            }
            .navigationTitle("Home")
        }
    }

    private func replayOnboarding() {
        appState.hasCompletedOnboarding = false
        try? modelContext.save()
    }
}
