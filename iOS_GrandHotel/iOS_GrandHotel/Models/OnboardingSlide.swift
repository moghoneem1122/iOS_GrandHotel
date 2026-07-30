//
//  OnboardingSlide.swift
//  iOS_GrandHotel
//

import Foundation
import SwiftData

@Model
final class OnboardingSlide {
    var title: String
    var details: String
    @Attribute(.externalStorage) var image: Data?
    var order: Int

    init(title: String, details: String, image: Data? = nil, order: Int) {
        self.title = title
        self.details = details
        self.image = image
        self.order = order
    }
}

@Model
final class AppState {
    var hasCompletedOnboarding: Bool

    init(hasCompletedOnboarding: Bool = false) {
        self.hasCompletedOnboarding = hasCompletedOnboarding
    }
}
