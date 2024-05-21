//
//  LanchScreen.swift
//  fridge&share_vk
//
//  Created by Елизавета Шерман on 14.05.2024.
//

import SwiftUI

struct LoaderView: View {
    @State private var rotationAngle: Double = 0
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack {
                Image("loader")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .rotationEffect(.degrees(rotationAngle))
                    .animation(Animation.linear(duration: 10).repeatForever(autoreverses: false))
                    .onAppear() {
                        self.rotationAngle = 360
                    }
            }
        }
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
