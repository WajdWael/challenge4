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
    var isLocked: Bool
    
    var body: some View {
        let word = words[child.currentWordIndex]
        
        ZStack {
            Color("PrimaryColor").edgesIgnoringSafeArea(.all)
            
            VStack{
                HStack{
                    NavigationLink(destination: New_Home_Page(child: child, completedWords:$completedWords, completedLetters: $completedLetters, isLocked: isLocked)) {
                        
                        Image(systemName: "house.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 81, height: 81)
                            .background(
                                RoundedRectangle(cornerRadius: 100)
                                    .fill(Color(red: 255 / 255, green: 195 / 255, blue: 63 / 255)) // Background color (#FFC33F)
                                    .shadow(color: Color(red: 255 / 255, green: 173 / 255, blue: 0 / 255), radius: 0, x: 5, y: 8)
                            )
                    }
                    Spacer()
                }.padding()
                
                Spacer()
                HStack{
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
                    }
                    
                }

                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(destination: PyramidView(
                        isActivityCompleted: $isActivityCompleted,
                        completedWords: $completedWords, completedLetters: $completedLetters,
                        child:child, isLocked:isLocked, word:word)) {
                        Image(systemName: "arrowshape.left.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 81, height: 81) // Expand to fill horizontal space
                            .background(
                                RoundedRectangle(cornerRadius: 100)
                                    .fill(Color(red: 255 / 255, green: 195 / 255, blue: 63 / 255)) // Background color (#FFC33F)
                                    .shadow(color: Color(red: 255 / 255, green: 173 / 255, blue: 0 / 255), radius: 0, x: 5, y: 8)
                            )
                    }
                    .onTapGesture {
                        child.moveToNextLetter()
                    }
                    .padding()
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}
