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

import SwiftData
import SwiftUI
import AVFoundation

struct FlashCardView: View {
    
    @ObservedObject var child: Child
    @Binding var isActivityCompleted: Bool
    @Binding var completedWords: [Bool]
    @Binding var completedLetters: [Bool]
   

    var body: some View {
        let word = words[child.currentWordIndex]

        ZStack {
            Color("PrimaryColor").edgesIgnoringSafeArea(.all)
            
            VStack(spacing:90){
                HStack{
                    // Right Side: Text
                    ZStack {
                        Color(word.backgroundColor)
                            .opacity(1.0)
                            
                        
                        Text(word.word)
                            .foregroundStyle(.white)
                            .bold()
                            .globalFont(size: 90)
                    }
                    .frame(width: 250, height: 350)
                    .cornerRadius(10)
                    .overlay(
                        Image(systemName: "speaker.wave.2.fill")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                            .padding(),
                        alignment: .topTrailing
                    )
                    
                    ZStack {
                        Image(word.imageName)
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
                    .frame(width: 250, height: 350)
                    .cornerRadius(10)
                    .background(.white)
                    
                }
                
                NavigationLink(destination: PyramidView(
                    isActivityCompleted: $isActivityCompleted,
                    completedWords: $completedWords, completedLetters: $completedLetters,
                    child:child, word:word
                )) {
                    Image(systemName: "arrow.forward.circle")
                        .resizable()
                        .foregroundStyle(Color.orange)
                        .frame(width: 78, height: 78)
                    
                }

            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
}
