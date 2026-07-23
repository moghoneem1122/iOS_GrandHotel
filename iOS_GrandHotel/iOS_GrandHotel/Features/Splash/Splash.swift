//
//  Splash.swift
//  iOS_GrandHotel
//
//  Created by Mohammed on 23/07/2026.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct SplashReducer {

    @ObservableState
    struct State: Equatable {
        var isSplashShown: Bool = true
    }

    enum Action {
        case hideSplash
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .hideSplash:
                state.isSplashShown = false
                return .none
            }
        }
    }
}

struct Splash: View {
    let store: StoreOf<SplashReducer>

    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                Color(
                    red: 40 / 255,
                    green: 83 / 255,
                    blue: 175 / 255
                )
                .ignoresSafeArea()

                Image("SplashIcon")
                    .resizable()
                    .frame(width: 89.7, height: 123.2)
                    .position(
                        x: geometry.size.width / 2,
                        y: 304.4 + (123.2 / 2)
                    )

                Text("grand_hotel")
                    .font(.custom("Jost-700-Bold", size: 40))
                    .kerning(0.05)
                    .foregroundStyle(.white)
                    .frame(width: 234, height: 48)
                    .position(
                        x: geometry.size.width / 2,
                        y: 461.6
                    )

                Text("find_your_perfect_stay")
                    .font(.custom("Jost-400-Regular", size: 14))
                    .kerning(0.05)
                    .foregroundStyle(.white)
                    .fixedSize(horizontal: true, vertical: false)
                    .position(
                        x: geometry.size.width / 2,
                        y: 496.6
                    )
                
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    Splash(store: Store(initialState: SplashReducer.State(), reducer: {
        SplashReducer()
    }))
}
