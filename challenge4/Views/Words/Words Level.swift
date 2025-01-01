//
//  Words Levels.swift
//  Baraem Al-Lugha
//
//  Created by Alaa Emad Alhamzi on 28/06/1446 AH.
//

import SwiftUI

struct Words_Levels: View {
    @ObservedObject var child: Child
    @Binding var completedWords: [Bool]
    @Binding var completedLetters: [Bool]
    @Binding  var isActivityCompleted : Bool

    var words: [Word] = [
        Word(word: "أرنب", imageName: "Rabbit", backgroundColor: "Pink",isCompleted: false),
        Word(word: "حصان", imageName: "Horse", backgroundColor: "Brown" ,isCompleted: false),
        Word(word: "بيت", imageName: "Home", backgroundColor: "Yellow",isCompleted: false)
    ]
    var isLocked: Bool
    

    var body: some View {
        NavigationStack{
            ZStack{
                Color("PrimaryColor").edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
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
                    VStack{
                        Text("مراحل الكلمات")
                            .globalFont(size: 100)
                            .bold()
                    }
                    VStack{
                        ScrollView(.horizontal){
                            HStack{
                                
                                NavigationLink(destination: FlashCardView(child: child, isActivityCompleted: $isActivityCompleted, completedWords: $completedWords, completedLetters: $completedLetters, isLocked:isLocked)){
                                    
                                    ZStack{
                                        
                                        Rectangle()
                                            .frame(width: 330, height: 380)
                                            .foregroundStyle(Color("SecondaryColor").opacity(0.6))
                                            .cornerRadius(20)
                                            .padding()
                                        
                                        Image("Rabbit")
                                    }
                                }
                                
                                
                                if completedWords[0] == true {
                                    
                                    NavigationLink(destination:FlashCardView(child: child, isActivityCompleted: $isActivityCompleted, completedWords: $completedWords, completedLetters: $completedLetters, isLocked: isLocked)){
                                        
                                        ZStack{
                                            
                                            Rectangle()
                                                .frame(width: 330, height: 380)
                                                .foregroundStyle(Color("SecondaryColor").opacity(0.6))
                                                .cornerRadius(20)
                                                .padding()
                                            
                                            
                                            Image("Horse")
                                            
                                            
                                            
                                        }
                                    }
                                    
                                }else{
                                    
                                    ZStack{
                                        Rectangle()
                                            .frame(width: 330, height: 380)
                                            .foregroundStyle(Color(.gray).opacity(0.6))
                                            .cornerRadius(20)
                                            .padding()
                                        
                                        Image("Lock")
                                    }
                                    
                                    
                                }
                                
                                
                                if completedWords[1] == true {
                                    
                                    NavigationLink(destination:FlashCardView(child: child, isActivityCompleted: $isActivityCompleted, completedWords: $completedWords, completedLetters: $completedLetters, isLocked: isLocked)){
                                        
                                        ZStack{
                                            
                                            Rectangle()
                                                .frame(width: 330, height: 380)
                                                .foregroundStyle(Color("SecondaryColor").opacity(0.6))
                                                .cornerRadius(20)
                                                .padding()
                                            
                                            
                                            Image("Home")
                                            
                                            
                                            
                                        }
                                    }
                                    
                                }else{
                                    
                                    ZStack{
                                        Rectangle()
                                            .frame(width: 330, height: 380)
                                            .foregroundStyle(Color(.gray).opacity(0.6))
                                            .cornerRadius(20)
                                            .padding()
                                        
                                        Image("Lock")
                                    }
                                    
                                    
                                }
                            }
                        }
                        
                    }.padding()
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}
