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
    
    var body: some View {
        
      
        NavigationStack{
            
            
            ZStack{
                
                Color("PrimaryColor").edgesIgnoringSafeArea(.all)
                
                VStack{
                    
                    HStack{
                       
                        Button {
                            
                        } label: {
                            Image(systemName: "arrowshape.backward")
                                .resizable()
                                .foregroundStyle(Color.orange)
                                .frame(width: 78, height: 78)
                        }
                        
                        
                        
                        .offset(x: -290)
                        
                        
                        Text("مراحل الكلمات")
                                              .globalFont(size: 100)
                                              .bold()

                        
                    }
                    
                    
                    
                  
                    
                    
                    Spacer()
                   
                   HStack{
                       
                       ScrollView(.horizontal){
                           
                           
//                           HStack{
//                               ForEach(0..<3){ index in
//                                   
//                                   ZStack{
//                                       
//                                       Rectangle()
//                                           .frame(width: 330, height: 380)
//                                           .foregroundStyle(Color("SecondaryColor").opacity(0.6))
//                                           .cornerRadius(20)
//                                           .padding()
//                                       
//                                       Image(words[index].imageName)
//                                   }
//                                   
//                               }
//                               
//                           }
                           
                           HStack{
                               
                               NavigationLink(destination: FlashCardView(child: child, isActivityCompleted: $isActivityCompleted, completedWords: $completedWords, completedLetters: $completedLetters)){
                                   
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
                                   
                                   NavigationLink(destination:FlashCardView(child: child, isActivityCompleted: $isActivityCompleted, completedWords: $completedWords, completedLetters: $completedLetters)){
                                       
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
                                   
                                   NavigationLink(destination:FlashCardView(child: child, isActivityCompleted: $isActivityCompleted, completedWords: $completedWords, completedLetters: $completedLetters)){
                                       
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
                           
                           
                           
                           
                       }.contentMargins(50, for: .scrollContent)
                   }
                    
                }
                
               
            }
        }
                
            .navigationBarBackButtonHidden(true)
         
                
            }
            
        
            
    
    }
