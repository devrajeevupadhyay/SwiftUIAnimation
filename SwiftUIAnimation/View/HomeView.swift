//
//  HomeView.swift
//  SwiftUIAnimation
//
//  Created by Rajeev  Upadhyay on 27/07/25.
//

import SwiftUI

struct HomeView: View {
    let animationItems = AnimationData.items
    
    var body: some View {
        NavigationStack {
            List(animationItems) { item in
                NavigationLink {
                    AnimationDetailView(animationType: item.animationType)
                } label: {
                    HStack {
                        Image(systemName: item.icon)
                            .foregroundColor(.blue)
                            .frame(width: 30)
                        Text(item.name)
                            .font(.headline)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Animation Demos")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
