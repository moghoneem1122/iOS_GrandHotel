//
//  Splash.swift
//  iOS_GrandHotel
//
//  Created by Mohammed on 23/07/2026.
//

import SwiftUI
import ComposableArchitecture
import BMSwiftUI

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
        
        ZStack{
            
            Colors.splashBackGround
                .ignoresSafeArea(edges: .all)
            VStack(){
                Image("SplashIcon")
                    .resizable()
                    .frame(width: 89.7, height: 123.2)
                
                Text("grand_hotel")
                    .font(.custom("Jost-Bold", size: 40))
                    .foregroundStyle(.white)
                    .frame(width: 234, height: 48)
                
                Text("find_your_perfect_stay")
                    .font(.custom("Jost-Regular", size: 14))
                    .foregroundStyle(.white)
                    .fixedSize(horizontal: true, vertical: false)
            }
        }
    }
}

#Preview {
    Splash(store: Store(initialState: SplashReducer.State(), reducer: {
        SplashReducer()
    }))
}
