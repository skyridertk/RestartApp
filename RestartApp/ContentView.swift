//
//  ContentView.swift
//  RestartApp
//
//  Created by Tanaka on 10/2/2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    

    var body: some View {
        ZStack {
            if isOnboardingViewActive {
//                OnboardingScreen()
                HomeScreen()
            } else {
                HomeScreen()
//                OnboardingScreen()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
