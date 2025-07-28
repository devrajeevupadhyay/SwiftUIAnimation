//
//  AnimationDetailView.swift
//  SwiftUIAnimation
//
//  Created by Rajeev  Upadhyay on 27/07/25.
//

import SwiftUI

import SwiftUI

struct AnimationDetailView: View {
    let animationType: AnimationItem.AnimationType
    @State private var isAnimating = false
    @State private var dragOffset = CGSize.zero
    @State private var particles: [Particle] = []
    @State private var morphState = false
    @State private var gradientProgress: CGFloat = 0
    @State private var angle: Angle = .degrees(0)
    @State private var shakeOffset: CGFloat = 0
    
    // For path animation
    let path = Path { path in
        path.move(to: CGPoint(x: 50, y: 50))
        path.addQuadCurve(to: CGPoint(x: 250, y: 50), control: CGPoint(x: 150, y: -50))
        path.addQuadCurve(to: CGPoint(x: 50, y: 250), control: CGPoint(x: 250, y: 150))
        path.addQuadCurve(to: CGPoint(x: 250, y: 250), control: CGPoint(x: 150, y: 350))
        path.addQuadCurve(to: CGPoint(x: 50, y: 50), control: CGPoint(x: -50, y: 150))
    }
    
    var body: some View {
        VStack {
            Text(animationTitle)
                .font(.title)
                .padding()
            
            Spacer()
            
            // The animated view
            animatedContent
            
            Spacer()
            
            if animationType != .particle && animationType != .fireworks {
                Button(action: {
                    withAnimation {
                        isAnimating.toggle()
                    }
                    
                    // Special handling for certain animations
                    switch animationType {
                    case .gradient:
                        withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                            gradientProgress = 1
                        }
                    case .threeD:
                        withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                            angle = .degrees(360)
                        }
                    case .shake:
                        withAnimation(.interactiveSpring(response: 0.2, dampingFraction: 0.2, blendDuration: 0.2)) {
                            shakeOffset = 20
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation(.interactiveSpring(response: 0.2, dampingFraction: 0.2, blendDuration: 0.2)) {
                                shakeOffset = -20
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            withAnimation(.interactiveSpring(response: 0.2, dampingFraction: 0.2, blendDuration: 0.2)) {
                                shakeOffset = 0
                            }
                        }
                    default:
                        break
                    }
                }) {
                    Text(isAnimating ? "Reset" : "Animate")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            } else {
                Button(action: {
                    isAnimating.toggle()
                    if isAnimating {
                        if animationType == .particle {
                            startParticles()
                        } else if animationType == .fireworks {
                            startFireworks()
                        }
                    } else {
                        particles.removeAll()
                    }
                }) {
                    Text(isAnimating ? "Stop" : "Start")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
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
                
                // Special handling for certain animations
                switch animationType {
                case .gradient:
                    withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                        gradientProgress = 1
                    }
                case .threeD:
                    withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                        angle = .degrees(360)
                    }
                case .particle:
                    startParticles()
                case .fireworks:
                    startFireworks()
                default:
                    break
                }
            }
        }
    }
    
    // MARK: - Animation Content
    
    @ViewBuilder
    private var animatedContent: some View {
        switch animationType {
        case .rotation:
            rotationAnimation
        case .scale:
            scaleAnimation
        case .opacity:
            opacityAnimation
        case .spring:
            springAnimation
        case .easeInOut:
            easeInOutAnimation
        case .colorChange:
            colorChangeAnimation
        case .customPath:
            customPathAnimation
        case .combined:
            combinedAnimation
        case .wave:
            waveAnimation
        case .particle:
            particleAnimation
        case .morphing:
            morphingAnimation
        case .drag:
            dragAnimation
        case .gradient:
            gradientAnimation
        case .threeD:
            threeDAnimation
        case .followPath:
            followPathAnimation
        case .shake:
            shakeAnimation
        case .fireworks:
            fireworksAnimation
        }
    }
    
    // MARK: - Individual Animations
    
    private var rotationAnimation: some View {
        Image(systemName: "arrow.2.circlepath")
            .font(.system(size: 60))
            .rotationEffect(.degrees(isAnimating ? 360 : 0))
            .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: isAnimating)
    }
    
    private var scaleAnimation: some View {
        Rectangle()
            .fill(Color.blue)
            .frame(width: isAnimating ? 100 : 50, height: isAnimating ? 100 : 50)
            .animation(.easeInOut(duration: 1).repeatForever(), value: isAnimating)
    }
    
    private var opacityAnimation: some View {
        Circle()
            .fill(Color.green)
            .frame(width: 100, height: 100)
            .opacity(isAnimating ? 0.2 : 1.0)
            .animation(.easeInOut(duration: 1).repeatForever(), value: isAnimating)
    }
    
    private var springAnimation: some View {
        Capsule()
            .fill(Color.orange)
            .frame(width: isAnimating ? 150 : 50, height: 50)
            .animation(.spring(response: 0.5, dampingFraction: 0.3, blendDuration: 0).repeatForever(), value: isAnimating)
    }
    
    private var easeInOutAnimation: some View {
        RoundedRectangle(cornerRadius: isAnimating ? 50 : 10)
            .fill(Color.purple)
            .frame(width: 100, height: 100)
            .animation(.easeInOut(duration: 1).repeatForever(), value: isAnimating)
    }
    
    private var colorChangeAnimation: some View {
        Circle()
            .fill(isAnimating ? Color.red : Color.blue)
            .frame(width: 100, height: 100)
            .animation(.easeInOut(duration: 1).repeatForever(), value: isAnimating)
    }
    
    private var customPathAnimation: some View {
        GeometryReader { geometry in
            Circle()
                .fill(Color.pink)
                .frame(width: 50, height: 50)
                .offset(x: isAnimating ? geometry.size.width - 60 : 10,
                        y: isAnimating ? geometry.size.height - 60 : 10)
                .animation(.easeInOut(duration: 2).repeatForever(), value: isAnimating)
        }
        .frame(height: 200)
    }
    
    private var combinedAnimation: some View {
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
    
    private var waveAnimation: some View {
        WaveView(amplitude: isAnimating ? 20 : 5, frequency: isAnimating ? 0.5 : 0.2)
            .fill(Color.blue)
            .frame(height: 100)
            .animation(.easeInOut(duration: 1).repeatForever(), value: isAnimating)
    }
    
    private var particleAnimation: some View {
        ZStack {
            ForEach(particles) { particle in
                Circle()
                    .fill(particle.color)
                    .frame(width: particle.size, height: particle.size)
                    .position(particle.position)
                    .opacity(particle.opacity)
            }
        }
        .frame(width: 300, height: 300)
    }
    
    private var morphingAnimation: some View {
        Group {
            if morphState {
                Circle()
                    .fill(Color.purple)
                    .frame(width: 100, height: 100)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.purple)
                    .frame(width: 100, height: 100)
            }
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.5), value: morphState)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5).repeatForever()) {
                morphState.toggle()
            }
        }
    }
    
    private var dragAnimation: some View {
        Circle()
            .fill(Color.green)
            .frame(width: 80, height: 80)
            .offset(dragOffset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation(.interactiveSpring()) {
                            dragOffset = value.translation
                        }
                    }
                    .onEnded { _ in
                        withAnimation(.spring()) {
                            dragOffset = .zero
                        }
                    }
            )
    }
    
    private var gradientAnimation: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(
                AngularGradient(
                    gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]),
                    center: .center,
                    angle: .degrees(gradientProgress * 360)
                )
            )
            .frame(width: 200, height: 200)
    }
    
    private var threeDAnimation: some View {
        Rectangle()
            .fill(Color.blue)
            .frame(width: 100, height: 100)
            .rotation3DEffect(angle, axis: (x: 1, y: 1, z: 0))
    }
    
    private var followPathAnimation: some View {
        GeometryReader { geometry in
            let bounds = path.boundingRect
            let scale = min(geometry.size.width / bounds.width, geometry.size.height / bounds.height)
            
            path
                .stroke(Color.blue, lineWidth: 2)
                .overlay(
                    Circle()
                        .fill(Color.red)
                        .frame(width: 20, height: 20)
                        .offset(x: -10, y: -10)
                        .modifier(FollowPathEffect(path: path, rotate: true, progress: isAnimating ? 1 : 0))
                    //.modifier(FollowPathEffect(path: path.scale(scale, anchor: .center), rotate: true, progress: isAnimating ? 1 : 0))
                )
                .scaleEffect(scale)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
        .frame(height: 300)
    }
    
    private var shakeAnimation: some View {
        Text("Shake Me!")
            .font(.title)
            .padding()
            .background(Color.orange)
            .cornerRadius(10)
            .offset(x: shakeOffset)
    }
    
    private var fireworksAnimation: some View {
        ZStack {
            ForEach(particles) { particle in
                Circle()
                    .fill(particle.color)
                    .frame(width: particle.size, height: particle.size)
                    .position(particle.position)
                    .opacity(particle.opacity)
            }
        }
        .frame(width: 300, height: 300)
    }
    
    // MARK: - Helper Methods
    
    private var animationTitle: String {
        switch animationType {
        case .rotation: return "Rotation Animation"
        case .scale: return "Scale Animation"
        case .opacity: return "Opacity Animation"
        case .spring: return "Spring Animation"
        case .easeInOut: return "Ease In Out Animation"
        case .colorChange: return "Color Change Animation"
        case .customPath: return "Custom Path Animation"
        case .combined: return "Combined Animations"
        case .wave: return "Wave Effect"
        case .particle: return "Particle System"
        case .morphing: return "Morphing Shapes"
        case .drag: return "Drag Animation"
        case .gradient: return "Animated Gradient"
        case .threeD: return "3D Rotation"
        case .followPath: return "Follow Path"
        case .shake: return "Shake Effect"
        case .fireworks: return "Fireworks"
        }
    }
    
    private func startParticles() {
        particles.removeAll()
        for _ in 0..<50 {
            let size = CGFloat.random(in: 5...15)
            let x = CGFloat.random(in: 0...300)
            let y = CGFloat.random(in: 0...300)
            let angle = Double.random(in: 0..<Double.pi * 2)
            let speed = Double.random(in: 0.5...2)
            let opacity = Double.random(in: 0.1...1.0)
            let color = [Color.red, .blue, .green, .yellow, .purple, .orange].randomElement()!
            
            let particle = Particle(
                position: CGPoint(x: x, y: y),
                size: size,
                color: color,
                angle: angle,
                speed: speed,
                opacity: opacity
            )
            
            particles.append(particle)
        }
        
        // Animate particles
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            if !isAnimating {
                timer.invalidate()
                return
            }
            
            withAnimation(.linear(duration: 0.05)) {
                for index in particles.indices {
                    particles[index].position.x += CGFloat(cos(particles[index].angle) * particles[index].speed)
                    particles[index].position.y += CGFloat(sin(particles[index].angle) * particles[index].speed)
                    
                    // Reset particles that go off screen
                    if particles[index].position.x < 0 || particles[index].position.x > 300 ||
                        particles[index].position.y < 0 || particles[index].position.y > 300 {
                        particles[index].position = CGPoint(x: CGFloat.random(in: 0...300), y: CGFloat.random(in: 0...300))
                    }
                }
            }
        }
    }
    
    private func startFireworks() {
        particles.removeAll()
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if !isAnimating {
                timer.invalidate()
                return
            }
            
            // Create explosion center
            let center = CGPoint(x: CGFloat.random(in: 50...250), y: CGFloat.random(in: 50...250))
            let color = [Color.red, .blue, .green, .yellow, .purple, .orange].randomElement()!
            
            // Create particles for explosion
            for _ in 0..<30 {
                let size = CGFloat.random(in: 3...8)
                let angle = Double.random(in: 0..<Double.pi * 2)
                let speed = Double.random(in: 1...5)
                let distance = Double.random(in: 0...50)
                let opacity = Double.random(in: 0.7...1.0)
                let lifetime = Int.random(in: 30...60) // Number of updates before fading
                
                let particle = Particle(
                    position: center,
                    size: size,
                    color: color,
                    angle: angle,
                    speed: speed,
                    opacity: opacity,
                    lifetime: lifetime,
                    distance: distance
                )
                
                particles.append(particle)
            }
        }
        
        // Animate particles
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            if !isAnimating {
                timer.invalidate()
                return
            }
            
            withAnimation(.linear(duration: 0.05)) {
                // Update existing particles
                for index in particles.indices {
                    if particles[index].lifetime > 0 {
                        particles[index].position.x += CGFloat(cos(particles[index].angle) * particles[index].speed)
                        particles[index].position.y += CGFloat(sin(particles[index].angle) * particles[index].speed)
                        particles[index].lifetime -= 1
                        
                        // Fade out as lifetime decreases
                        if particles[index].lifetime < 10 {
                            particles[index].opacity = Double(particles[index].lifetime) / 10.0
                        }
                    }
                }
                
                // Remove dead particles
                particles.removeAll { $0.lifetime <= 0 }
            }
        }
    }
}

// MARK: - Helper Views and Structs

struct WaveView: Shape {
    var amplitude: CGFloat
    var frequency: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: 0, y: height))
        
        for x in stride(from: 0, through: width, by: 1) {
            let relativeX = x / width
            let sine = sin(relativeX * .pi * 2 * frequency)
            let y = height / 2 + amplitude * CGFloat(sine)
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        
        return path
    }
}

struct Particle: Identifiable {
    let id = UUID()
    var position: CGPoint
    var size: CGFloat
    var color: Color
    var angle: Double
    var speed: Double
    var opacity: Double
    var lifetime: Int = 1000 // Default high value for non-fireworks
    var distance: Double = 0 // For fireworks
}

struct FollowPathEffect: GeometryEffect {
    let path: Path
    let rotate: Bool
    var progress: CGFloat
    
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        if !rotate {
            let point = path.trimmedPath(from: 0, to: progress).currentPoint ?? .zero
            return ProjectionTransform(CGAffineTransform(translationX: point.x, y: point.y))
        } else {
            let trim = path.trimmedPath(from: max(0, progress - 0.0001), to: progress)
            let point = trim.currentPoint ?? .zero
            let angle = trim.angle ?? .zero
            let transform = CGAffineTransform(translationX: point.x, y: point.y)
                .rotated(by: angle)
            return ProjectionTransform(transform)
        }
    }
}

extension Path {
    var angle: CGFloat? {
            let points = self.points()
            guard points.count >= 2 else { return nil }
            let p1 = points[points.count - 1]
            let p2 = points[points.count - 2]
            return atan2(p2.y - p1.y, p2.x - p1.x)
        }
    
    func points() -> [CGPoint] {
        var points: [CGPoint] = []
        forEach { element in
            switch element {
            case .move(to: let point),
                 .line(to: let point),
                 .quadCurve(to: let point, control: _),
                 .curve(to: let point, control1: _, control2: _):
                
                 //.addArc(center: let point, radius: _, startAngle: _, endAngle: _, clockwise: _):
                points.append(point)
            case .closeSubpath:
                break
            }
        }
        return points
    }
}
