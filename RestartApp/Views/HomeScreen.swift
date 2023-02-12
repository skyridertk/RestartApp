//
//  HomeScreen.swift
//  RestartApp
//
//  Created by Tanaka on 10/2/2023.
//

import SwiftUI

struct HomeScreen: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    @State private var isAnimating: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            ZStack {
                CircleGroupComponent(ShapeColor: Color.gray, ShapeOpacity: 0.1)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                .padding()
                .offset(y: isAnimating ? 35: -35)
                .animation(.easeInOut(duration: 4).repeatForever(), value: isAnimating)
            }
            
            Text("The time that leads to happiness is what we should cherish the most with our loved")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    playSound(sound: "success", type: "mp3")
                    isOnboardingViewActive = false
                }
            }){
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold
                    )
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                isAnimating = true
            })
        })
    }
        
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
