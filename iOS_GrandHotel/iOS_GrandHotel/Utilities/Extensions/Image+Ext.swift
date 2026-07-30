//
//  AppImage.swift
//  iOS_GrandHotel
//
//  Created by Mohammed on 26/07/2026.
//

import SwiftUI
import UIKit

extension Image{
    //MARK: - SplashView
    static let logo = Image("SplashIcon")

    //MARK: - OnboardingRootVoew
    static let FirstOnboardingImage = Image("FirstSlide")
    static let secondOnboardingImage = Image("SecondSlide")
    static let thirdOnboardingImage = Image("ThirdSlide")

    static func onboardingImageData(for order: Int) -> Data? {
        let imageNames = ["FirstSlide", "SecondSlide", "ThirdSlide"]
        guard imageNames.indices.contains(order) else { return nil }
        return UIImage(named: imageNames[order])?.jpegData(compressionQuality: 0.8)
    }
}
