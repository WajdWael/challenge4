//
//  HomeView.swift
//  challenge4
//
//  Created by Wajd Wael on 18/06/1446 AH.
//
//

import SwiftUI

struct HomeViewWords: View {
    
     @ObservedObject var child: Child
     @State private var isActivityCompleted = false
     @Binding  var completedWords: [Bool]
     @Binding  var completedLetters: [Bool]

    var body: some View {
        let word = words[child.currentWordIndex]
        
        ZStack{
            NavigationStack{
                GeometryReader { geometry in
                    ZStack {
                        Image("Charchter")
                            .position(x: geometry.size.width * 1.0 - 270, y: geometry.size.height - 150)
                        
                        Image("Path___")
                            .scaleEffect(1.5)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        
                        HStack {
                            NavigationLink(destination: TutorialView(completedLetters: $completedLetters, child: child)) {
                                Image("Brown_home")
                                
                            }.offset(x: 680, y: -250)
                            
                            NavigationLink(destination: FlashCardView(child: child, isActivityCompleted: $isActivityCompleted, completedWords: $completedWords, completedLetters: $completedLetters)) {
                                Image("Bage_house")
                                
                            }.offset(x: -500, y: 200)
                        }
                    }
                }
                .navigationBarBackButtonHidden(true)
                .globalFont(size: 150)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("PrimaryColor"))
                .ignoresSafeArea()
            }
            
            VStack {
                ForEach(completedWords.indices, id: \.self) { index in
                    if completedWords[index] {
                        let completedWord = words[index] // Fetch the word for the current index
                        
                        
                        ZStack {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 100, height: 100)
                                .shadow(color: Color.black, radius: 12)
                            
                            Text(completedWord.word) // Use the dynamically fetched word
                                .font(.largeTitle)
                                .foregroundStyle(Color(.white))
                                .bold()
                        }
                    }
                }
            }
        }

    }
}
