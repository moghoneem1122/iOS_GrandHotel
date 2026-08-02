//
//  WalkthroughView.swift
//  iOS_GrandHotel
//

import SwiftUI
import SwiftData
import BMSwiftUI



struct WalkthroughView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \OnboardingSlide.order) private var slides: [OnboardingSlide]
    let appState: AppState
    @State private var currentPage = 0

    var body: some View {
        if slides.isEmpty {
            LogInView()
        } else {
            ZStack {
                TabView(selection: $currentPage) {
                    ForEach(slides.indices, id: \.self) { index in
                        WalkthroughPage(slide: slides[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .ignoresSafeArea()

                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Button("Skip", action: completeOnboarding)
                            .textStyle(size: 16, weight: .regular, color: .white)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 12)

                    Spacer()

                    if currentPage != slides.count - 1 {
                        PageIndicator(currentPage: currentPage, count: slides.count)
                            .padding(.bottom, 32)
                    }

                    Button(currentPage == slides.count - 1 ? "Get Started" : "Continue") {
                        if currentPage == slides.count - 1 {
                            completeOnboarding()
                        } else {
                            withAnimation { currentPage += 1 }
                        }
                    }
                    .textStyle(size: 18, weight: .bold, color: .white)
                    .frame(width: 327, height: 58)
                    .background(Color.splashBackGround)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .padding(.bottom, 28)
                }
            }
            .onChange(of: slides.count) { _, newCount in
                currentPage = min(currentPage, max(newCount - 1, 0))
            }
        }
    }

 func completeOnboarding() {
        appState.hasCompletedOnboarding = true
        try? modelContext.save()
    }
}

 struct WalkthroughPage: View {
    let slide: OnboardingSlide

    var body: some View {
        ZStack {
            
            Group {
                if let imageData = slide.image, let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .setFrame(width:450)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFill()
                        .setFrame(width:450)
                }
            }
            
            .clipped()

            LinearGradient(
                colors: [.clear, .black.opacity(0.35), .black],
                startPoint: .center,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing:8){Text(slide.title)
                    .textStyle(size:24,
                        weight: .bold,
                        color: .white
                    )
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                Text(slide.details)
                    .textStyle(size:14,
                        weight: .regular,
                        color: .white.opacity(0.85))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)}
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
            
            
        }.ignoresSafeArea()
    }

}

private struct PageIndicator: View {
    let currentPage: Int
    let count: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<count, id: \.self) { index in
                Capsule()
                    .fill(index == currentPage ? .white : .white.opacity(0.45))
                    .frame(width: index == currentPage ? 20 : 7, height: 7)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: currentPage)
        
    }
}
