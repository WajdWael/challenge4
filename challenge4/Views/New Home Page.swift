//
//  New Home Page.swift
//  Baraem Al-Lugha
//
//  Created by Alaa Emad Alhamzi on 30/06/1446 AH.
//

import SwiftUI
struct New_Home_Page: View {
    
    @Environment(\.modelContext) var context
    
    @ObservedObject var child: Child
    @Binding var completedWords: [Bool]
    @Binding var completedLetters: [Bool]
    var isLocked: Bool

    var body: some View {
        NavigationStack {
            ZStack {
                Image("bkImage")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            NavigationLink(destination: Letters_Levels(child: child, completedLetters: $completedLetters, completedWords: $completedWords, isLocked: isLocked)) {
                                VStack {
                                    Image("Letter_home")
                                        .resizable()
                                        .frame(width: 713, height: 673)
                                    Text("بيت الأحرف")
                                        .globalFont(size: 48)
                                        .bold()
                                        .foregroundColor(.black)
                                }
                            }
                            
                            // Words Home is always accessible if isLocked is false
                            if !isLocked || completedLetters.allSatisfy({ $0 }) {
                                NavigationLink(destination: Words_Levels(child: child, completedWords: $completedWords, completedLetters: $completedLetters, isActivityCompleted: .constant(false), isLocked: isLocked)) {
                                    VStack {
                                        Image("Word_home")
                                            .resizable()
                                            .frame(width: 713, height: 673)
                                        Text("بيت الكلمات")
                                            .globalFont(size: 48)
                                            .bold()
                                            .foregroundColor(.black)
                                    }
                                }
                            } else {
                                ZStack {
                                    Image("Word_home")
                                        .resizable()
                                        .frame(width: 713, height: 673)
                                        .opacity(0.3)
                                    
                                    Image(systemName: "lock.fill")
                                        .foregroundColor(.red)
                                        .font(.largeTitle)
                                }
                            }
                        }
                        .navigationBarBackButtonHidden(true)
                    }
                }
            }
        }
    }
}
