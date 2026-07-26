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
       
    }
    
    enum Action {
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}

struct Splash: View {
    let store: StoreOf<SplashReducer>
    
    var body: some View {
        
        ZStack{
            
            Color.splashBackGround
                .ignoresSafeArea(edges: .all)
            VStack(){
                Image.logo
                    .setFrame(width: 89.7, height:123.2)
                
                Text(AppLocalization.splashTitle)
                    .font(AppFont.splashTitle)
                    .foregroundStyle(.white)
                
                Text(AppLocalization.splashSubTitle)
                    .font(AppFont.splashSubTitle)
                    .foregroundStyle(.white)
                
                                }
        }
    }
}

#Preview {
    Splash(store: Store(initialState: SplashReducer.State(), reducer: {
        SplashReducer()
    }))
}
