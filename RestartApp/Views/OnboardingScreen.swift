//
//  OnboardingScreen.swift
//  RestartApp
//
//  Created by Tanaka on 10/2/2023.
//

import SwiftUI

struct OnboardingScreen: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageoffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTitle: String = "Share."
    
    let hapticFeeback = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 20) {
                Spacer()
                
                VStack(spacing: 0){
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                    
                    Text("""
Its not how much we give  buy how much love we put into diving
""")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(TextAlignment.center)
                    .padding(.horizontal, 10)
                }
                .opacity(isAnimating ? 1: 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                ZStack {
                    CircleGroupComponent(ShapeColor: Color.white, ShapeOpacity: 0.2)
                        .offset(x: imageoffset.width * -1)
                        .blur(radius: abs(imageoffset.width) / 5)
                        .animation(.easeOut(duration: 1), value: imageoffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageoffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageoffset.width / 20)))
                        .gesture(DragGesture()
                            .onChanged{gesture in
                                if abs(imageoffset.width) <= 150 {
                                    imageoffset = gesture.translation
                                    
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOpacity = 0
                                        textTitle = "Give."
                                    }
                                }
                            }
                            .onEnded {_ in
                                imageoffset = .zero
                                
                                withAnimation(.linear(duration: 0.25)) {
                                    indicatorOpacity = 1
                                    textTitle = "Share."
                                }
                            }
                        )
                        .animation(.easeOut(duration: 1), value: imageoffset)
                }
                .overlay(Image(systemName: "arrow.left.and.right.circle")
                    .font(.system(size: 44, weight: .ultraLight))
                    .foregroundColor(.white)
                    .offset(y: 20)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                    .opacity(indicatorOpacity)
                    , alignment: .bottom
                )
                
                Spacer()
                
                ZStack {
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    Text("Get started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)
                        
                        Spacer()
                    }
                    
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))
                            
                            Circle()
                                .fill(Color.black.opacity(0.2))
                                .padding(8)
                            
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundColor(.white)
                    .frame(width: 80, height: 80, alignment: .center)
                    .offset(x: buttonOffset)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                if gesture.translation.width > 0  && buttonOffset <= buttonWidth - 80{
                                    buttonOffset = gesture.translation.width
                                }
                            }
                            .onEnded {_ in
                                withAnimation(Animation.easeOut(duration: 0.4)){
                                    if buttonOffset > buttonWidth / 2 {
                                        hapticFeeback.notificationOccurred(.success)
                                        playSound(sound: "chimeup", type: "mp3")
                                        buttonOffset = buttonWidth - 80
                                        isOnboardingViewActive = false
                                    } else {
                                        hapticFeeback.notificationOccurred(.warning)
                                        buttonOffset = 0
                                    }
                                }
                                
                            }
                            
                    )
                        
                        Spacer()
                    }
                }
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
            }
            
        }
        .onAppear(perform: {
            isAnimating = true
        })
        .preferredColorScheme(.dark)
        
    }
}

struct OnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen()
    }
}
