//
//  HomeViewLetters.swift
//  Baraem Al-Lugha
//
//  Created by Wajd Wael on 23/06/1446 AH.
//

import SwiftUI

struct HomeViewLetters: View {
    @ObservedObject var child: Child
    @State private var isActivityCompleted = false
    @Binding  var completedLetters: [Bool]
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Image("Charchter")
                        .position(x: geometry.size.width * 1.0 - 270, y: geometry.size.height - 150)
                    
                    Image("Path___")
                        .scaleEffect(1.5)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    
                    VStack {
                        NavigationLink(destination: TutorialView(completedLetters: $completedLetters, child: child)) {
                            Image("Brown_home")
                        }.position(x: geometry.size.width * 0.3, y: geometry.size.height * 0.7)
                            .scaleEffect(1)
                        
                        Image("WordsHouseLocked")
                            .position(x: geometry.size.width * 0.85, y: geometry.size.height * -0.18)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .globalFont(size: 150)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("PrimaryColor"))
            .ignoresSafeArea()
        }
    }
}
