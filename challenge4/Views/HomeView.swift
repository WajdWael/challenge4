//
//  HomeView.swift
//  challenge4
//
//  Created by Wajd Wael on 18/06/1446 AH.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color("InterfacesColor").ignoresSafeArea(.all)
                
                // Path between the homes
                Image("Path")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 1500, height: 3300) // Adjust size to fit design
                    .position(x: 700, y: 450)
                
                
                NavigationLink{
                    FlashcardView()
                        .navigationBarBackButtonHidden(true)
                }label:{
                    Image("Bage_home")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 260, height: 260) // Adjust size to fit design
                }
                .position(x: 200, y: 150) // Adjust
                
                // Bottom Right Home (BrownHome)
                NavigationLink {
                    TutorialView()
                        .navigationBarBackButtonHidden(true) // Hides the back button
                } label: {
                    Image("Brown_home")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 400) // Adjust size to fit design
                }
                .position(x: 900, y: 550) // Adjust coordinates to match layout
                
                // Bottom Left Character Cloud
                Image("Charchter")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 517, height: 721) // Adjust size to fit design
                    .position(x: 150, y: 700) // Adjust coordinates to match layout
            }
            
            .navigationBarBackButtonHidden(true)
            
            
        }
    }
}
#Preview {
    HomeView()
}
