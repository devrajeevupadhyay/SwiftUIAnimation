//
//  AnimationDetailView.swift
//  SwiftUIAnimation
//
//  Created by Rajeev  Upadhyay on 27/07/25.
//

import SwiftUI

struct AnimationDetailView: View {
    let animationType: AnimationItem.AnimationType
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            Text(animationTitle)
                .font(.title)
                .padding()
            
            Spacer()
            
            // The animated view
            animatedContent
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    isAnimating.toggle()
                }
            }) {
                Text(isAnimating ? "Reset" : "Animate")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            // Auto-trigger animation when view appears
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    isAnimating = true
                }
            }
        }
    }
    
    private var animationTitle: String {
        switch animationType {
        case .rotation:
            return "Rotation Animation"
        case .scale:
            return "Scale Animation"
        case .opacity:
            return "Opacity Animation"
        case .spring:
            return "Spring Animation"
        case .easeInOut:
            return "Ease In Out Animation"
        case .colorChange:
            return "Color Change Animation"
        case .customPath:
            return "Custom Path Animation"
        case .combined:
            return "Combined Animations"
        }
    }
    
    @ViewBuilder
    private var animatedContent: some View {
        switch animationType {
        case .rotation:
            Image(systemName: "arrow.2.circlepath")
                .font(.system(size: 60))
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: isAnimating)
            
        case .scale:
            Rectangle()
                .fill(Color.blue)
                .frame(width: isAnimating ? 100 : 50, height: isAnimating ? 100 : 50)
                .animation(.easeInOut(duration: 1).repeatForever(), value: isAnimating)
            
        case .opacity:
            Circle()
                .fill(Color.green)
                .frame(width: 100, height: 100)
                .opacity(isAnimating ? 0.2 : 1.0)
                .animation(.easeInOut(duration: 1).repeatForever(), value: isAnimating)
            
        case .spring:
            Capsule()
                .fill(Color.orange)
                .frame(width: isAnimating ? 150 : 50, height: 50)
                .animation(.spring(response: 0.5, dampingFraction: 0.3, blendDuration: 0).repeatForever(), value: isAnimating)
            
        case .easeInOut:
            RoundedRectangle(cornerRadius: isAnimating ? 50 : 10)
                .fill(Color.purple)
                .frame(width: 100, height: 100)
                .animation(.easeInOut(duration: 1).repeatForever(), value: isAnimating)
            
        case .colorChange:
            Circle()
                .fill(isAnimating ? Color.red : Color.blue)
                .frame(width: 100, height: 100)
                .animation(.easeInOut(duration: 1).repeatForever(), value: isAnimating)
            
        case .customPath:
            GeometryReader { geometry in
                Circle()
                    .fill(Color.pink)
                    .frame(width: 50, height: 50)
                    .offset(x: isAnimating ? geometry.size.width - 60 : 10,
                            y: isAnimating ? geometry.size.height - 60 : 10)
                    .animation(.easeInOut(duration: 2).repeatForever(), value: isAnimating)
            }
            .frame(height: 200)
            
        case .combined:
            Image(systemName: "heart.fill")
                .font(.system(size: 60))
                .foregroundColor(isAnimating ? .red : .blue)
                .scaleEffect(isAnimating ? 1.5 : 1.0)
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .animation(
                    .easeInOut(duration: 1.5)
                    .repeatForever(),
                    value: isAnimating
                )
        }
    }
}
