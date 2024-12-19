//
//  TutorialView.swift
//  challenge4
//
//  Created by Wajd Wael on 18/06/1446 AH.
//

import SwiftUI

struct TutorialView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color("InterfacesColor").ignoresSafeArea(.all)
                
                VStack(spacing: 90) {
                    Text("Welcome to the letter tutorial view ")
                    
                    NavigationLink(destination: ColoringView().navigationBarBackButtonHidden(true)) {
                        Image(systemName: "arrow.backward.circle") // Forward arrow
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
    TutorialView()
}
