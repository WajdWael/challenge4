//
//  FlashCardView.swift
//  challenge4
//
//  Created by Wajd Wael on 18/06/1446 AH.
//
//
//  FlashCardView.swift
//  challenge4
//
//  Created by Wajd Wael on 18/06/1446 AH.
//

import SwiftUI
import SwiftData


struct FlashCardView: View {
    @State private var isFlipped = false
    @State private var isLevelOne = true
    @State private var flashcards = [
        FlashCard(textBackgroundColor:"أرنب", imageBackgroundColor: "Pink" ,textColor:"black" ,text:"white")
    ]
 
    var body: some View {
        NavigationStack {
            ZStack {
                Color("PrimaryColor").ignoresSafeArea(.all)
                
                VStack(spacing:90) {
                    
                    ProgressBarView(currentLevel: isLevelOne ? 1 : 2)
                
                    HStack(spacing:0){
                        
                        Image("Rabbit")
                            .padding()
                            .frame(width: 330, height: 332)
                            .background(Color.white)
                            .cornerRadius(20)
                            
                        Text("أرنب")
                            .globalFont(size: 90)
                            .font(.largeTitle)
                            .padding()
                            .frame(width: 330, height: 332)
                            .background(Color("FlashCardPink"))
                            .cornerRadius(20)
                    }
                    
                    
                    
                    // Navigation to PyramidPage
                    NavigationLink(destination: PyramidView()) {
                        Image(systemName: "arrow.backward.circle")
                            .resizable()
                            .foregroundStyle(Color("ProgressBarColor"))
                            .frame(width: 78, height: 78)
                    }
                    .padding(.top, 40)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview{
    FlashCardView()
}
