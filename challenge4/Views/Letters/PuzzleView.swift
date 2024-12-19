//
//  PuzzleView.swift
//  challenge4
//
//  Created by Wajd Wael on 18/06/1446 AH.
//

import SwiftUI

struct PuzzleView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color("InterfacesColor").ignoresSafeArea(.all)
                
                VStack(spacing: 90) {
                    Text("Welcome to the puzzle view")
                    
                    NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true)){
                        
                        Image(systemName: "checkmark.circle") // Forward arrow for next view
                            .resizable()
                            .foregroundStyle(Color.orange)
                            .frame(width: 78, height: 78)
                        
                    }
                }
            }
            .navigationBarBackButtonHidden(true) // Hides the default back button
        }
    }
}
#Preview {
    PuzzleView()
}
