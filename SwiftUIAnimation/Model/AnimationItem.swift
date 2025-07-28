//
//  AnimationModel.swift
//  SwiftUIAnimation
//
//  Created by Rajeev  Upadhyay on 27/07/25.
//

import SwiftUI

struct AnimationItem: Identifiable {
    let id = UUID()
    let name: String
    let animationType: AnimationType
    let icon: String
    
    enum AnimationType {
        case rotation
        case scale
        case opacity
        case spring
        case easeInOut
        case colorChange
        case customPath
        case combined
        case wave
        case particle
        case morphing
        case drag
        case gradient
        case threeD
        case followPath
        case shake
        case fireworks
    }
}

class AnimationData {
    static let items: [AnimationItem] = [
        AnimationItem(name: "Rotation", animationType: .rotation, icon: "arrow.2.circlepath"),
        AnimationItem(name: "Scale", animationType: .scale, icon: "arrow.up.left.and.arrow.down.right"),
        AnimationItem(name: "Opacity", animationType: .opacity, icon: "eye"),
        AnimationItem(name: "Spring", animationType: .spring, icon: "spring"),
        AnimationItem(name: "Ease In Out", animationType: .easeInOut, icon: "slowmo"),
        AnimationItem(name: "Color Change", animationType: .colorChange, icon: "paintpalette"),
        AnimationItem(name: "Custom Path", animationType: .customPath, icon: "point.fill.topleft.down.curvedto.point.fill.bottomright.up"),
        AnimationItem(name: "Combined Animations", animationType: .combined, icon: "square.stack.3d.up"),
        AnimationItem(name: "Wave Effect", animationType: .wave, icon: "water.waves"),
        AnimationItem(name: "Particle System", animationType: .particle, icon: "sparkles"),
        AnimationItem(name: "Morphing Shapes", animationType: .morphing, icon: "square.circle"),
        AnimationItem(name: "Drag Animation", animationType: .drag, icon: "hand.draw"),
        AnimationItem(name: "Animated Gradient", animationType: .gradient, icon: "sun.min"),
        AnimationItem(name: "3D Rotation", animationType: .threeD, icon: "cube"),
        AnimationItem(name: "Follow Path", animationType: .followPath, icon: "map"),
        AnimationItem(name: "Shake Effect", animationType: .shake, icon: "exclamationmark.triangle"),
        AnimationItem(name: "Fireworks", animationType: .fireworks, icon: "party.popper")
    ]
}
