//
//  Letters Levels.swift
//  Baraem Al-Lugha
//
//  Created by Alaa Emad Alhamzi on 28/06/1446 AH.
//

import SwiftUI

struct Letters_Levels: View {
    
    @ObservedObject var child: Child
    @Binding  var completedLetters: [Bool]
    
    //
    //    var letters: [Letter] = [
    //        Letter(
    //            letter: "أ",
    //            coloringCanvas: "NewA-1",
    //            puzzleImage: "puzzle-A",
    //            videoTutorial: "alef__letter",
    //            isCompleted: false
    //        ),
    //        Letter(
    //            letter: "ب ت ث",
    //            coloringCanvas: "NewBCD-2",
    //            puzzleImage: "puzzle-Group1",
    //            videoTutorial: "first_group_letters",
    //            isCompleted: false
    //        ),
    //        Letter(
    //            letter: "ي",
    //            coloringCanvas: "NewZ-3",
    //            puzzleImage: "Puzzle-y",
    //            videoTutorial: "yaa_letter",
    //            isCompleted: false
    //        ),
    //    ]
    
    var body: some View {
        
        
        NavigationStack{
            
            
            ZStack{
                
                Color("PrimaryColor").edgesIgnoringSafeArea(.all)
                
                VStack{
                    
                    HStack{
                        
                        /* NavigationLink(destination: New_Home_Page())*/ Button(action: {
                            // make acction
                        }, label: {
                            Image(systemName: "arrowshape.backward")
                                .resizable()
                                .foregroundStyle(Color.orange)
                                .frame(width: 78, height: 78)
                        }).offset(x: -230)
                        
                        
                        
                        Text("مراحل الحروف")
                            .globalFont(size: 100)
                            .bold()
                        
                        
                        
                        
                    }
                    
                    // Spacer()
                    
                    HStack{
                        
                        ScrollView(.horizontal){
                            
                            
                            HStack{
                                
                                    
                                    
                                    
                                    
                                        
                                        
                                        NavigationLink(destination:TutorialView(completedLetters: $completedLetters, child: child)){
                                            
                                            ZStack{
                                                
                                                Rectangle()
                                                    .frame(width: 330, height: 380)
                                                    .foregroundStyle(Color("SecondaryColor").opacity(0.6))
                                                    .cornerRadius(20)
                                                    .padding()
                                                
                                                Text("أ")
                                                    .globalFont(size: 30)
                                                    .fontWeight(.bold)
                                                    .padding()
                                                    .foregroundColor(.black)
                                                    .cornerRadius(10)
                                            }
                                        }
                                
                                
                                if completedLetters[0] == true {
                                    NavigationLink(destination:TutorialView(completedLetters: $completedLetters, child: child)){
                                        
                                        ZStack{
                                            
                                            Rectangle()
                                                .frame(width: 330, height: 380)
                                                .foregroundStyle(Color("SecondaryColor").opacity(0.6))
                                                .cornerRadius(20)
                                                .padding()
                                            
                                            Text("ب ت ث")
                                                .globalFont(size: 30)
                                                .fontWeight(.bold)
                                                .padding()
                                                .foregroundColor(.black)
                                                .cornerRadius(10)
                                            
                                            
                                           
                                               
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
                                
                                
                                
                                if completedLetters[1] == true{
                                    NavigationLink(destination:TutorialView(completedLetters: $completedLetters, child: child)){
                                        
                                        ZStack{
                                            
                                            Rectangle()
                                                .frame(width: 330, height: 380)
                                                .foregroundStyle(Color("SecondaryColor").opacity(0.6))
                                                .cornerRadius(20)
                                                .padding()
                                            
                                            Text("ي")
                                                .globalFont(size: 30)
                                                .fontWeight(.bold)
                                                .padding()
                                                .foregroundColor(.black)
                                                .cornerRadius(10)
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
                                    
                                }
                                
                            }.contentMargins(50, for: .scrollContent)
                        }
                    }.navigationBarBackButtonHidden(true)
                    
                    
                    
                }
            }
            
            
            
   
    


//#Preview {
//    Letters_Levels(completedLetters: $completedLetters, child: child)
//}
