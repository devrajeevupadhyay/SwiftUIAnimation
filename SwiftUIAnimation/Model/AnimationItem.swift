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
    
    enum AnimationType {
        case rotation
        case scale
        case opacity
        case spring
        case easeInOut
        case colorChange
        case customPath
        case combined
    }
}

class AnimationData {
    static let items: [AnimationItem] = [
        AnimationItem(name: "Rotation", animationType: .rotation),
        AnimationItem(name: "Scale", animationType: .scale),
        AnimationItem(name: "Opacity", animationType: .opacity),
        AnimationItem(name: "Spring", animationType: .spring),
        AnimationItem(name: "Ease In Out", animationType: .easeInOut),
        AnimationItem(name: "Color Change", animationType: .colorChange),
        AnimationItem(name: "Custom Path", animationType: .customPath),
        AnimationItem(name: "Combined Animations", animationType: .combined)
    ]
}
