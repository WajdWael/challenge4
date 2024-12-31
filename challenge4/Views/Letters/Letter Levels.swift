//
//  Letters Levels.swift
//  Baraem Al-Lugha
//
//  Created by Alaa Emad Alhamzi on 28/06/1446 AH.
//

import SwiftUI

struct Letters_Levels: View {
    
    
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
                            ForEach(0..<3){ index in
                                
                                ZStack{
                                    
                                    Rectangle()
                                        .frame(width: 330, height: 380)
                                        .foregroundStyle(Color("SecondaryColor").opacity(0.6))
                                        .cornerRadius(20)
                                        .padding()
                                    
                                    Text(letters[index].letter)
                                        .font(.largeTitle)
                                }
                                
                            }
                            
                        }
                        
                    }.contentMargins(50, for: .scrollContent)
                }
            }
            
            
            
        }
        
       // .navigationBarBackButtonHidden(true)
        
        
    }
    
}

#Preview {
    Letters_Levels()
}
