//
//  Letters Levels.swift
//  Baraem Al-Lugha
//
//  Created by Alaa Emad Alhamzi on 28/06/1446 AH.
//

import SwiftUI

struct Letters_Levels: View {
    
    @ObservedObject var child: Child
    @Binding var completedLetters: [Bool]
    @Binding var completedWords: [Bool]
    @State var isActivityCompleted: Bool = true
    var isLocked: Bool

    var body: some View {
        NavigationStack {
            ZStack {
                Color("PrimaryColor").edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        Button(action: {
                            // تنفيذ الإجراء المطلوب عند الرجوع
                        }, label: {
                            Image(systemName: "arrowshape.backward")
                                .resizable()
                                .foregroundStyle(Color.orange)
                                .frame(width: 78, height: 78)
                        })
                        .offset(x: -230)
                        
                        Text("مراحل الحروف")
                            .globalFont(size: 100)
                            .bold()
                    }
                    
                    HStack {
                        ScrollView(.horizontal) {
                            HStack {
                                // مستطيل للألف
                                NavigationLink(destination: TutorialView(completedLetters: $completedLetters, child: child, completedWords: $completedWords, isActivityCompleted: $isActivityCompleted, isLocked: isLocked)) {
                                    ZStack {
                                        Image("Image_Alef") // صورة الحرف "أ"
                                            .resizable()
                                            .frame(width: 330, height: 434)
                                            .cornerRadius(20)
                                            .padding()
                                    }
                                }
                                
                                // مستطيل للباء والتاء والثاء
                                if completedLetters[0] == true {
                                    NavigationLink(destination: TutorialView(completedLetters: $completedLetters, child: child, completedWords: $completedWords, isActivityCompleted: $isActivityCompleted, isLocked: isLocked)) {
                                        ZStack {
                                            Image("Image_Ba_Ta_Tha") // صورة "ب ت ث"
                                                .resizable()
                                                .frame(width: 330, height: 434)
                                                .cornerRadius(20)
                                                .padding()
                                        }
                                    }
                                } else {
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 330, height: 434)
                                            .foregroundStyle(Color(.gray).opacity(0.6))
                                            .cornerRadius(20)
                                            .padding()
                                        
                                        Image("Lock") // صورة القفل
                                    }
                                }
                                
                                // مستطيل للياء
                                if completedLetters[1] == true {
                                    NavigationLink(destination: TutorialView(completedLetters: $completedLetters, child: child, completedWords: $completedWords, isActivityCompleted: $isActivityCompleted, isLocked: isLocked)) {
                                        ZStack {
                                            Image("Image_Ya") // صورة "ي"
                                                .resizable()
                                                .frame(width: 330, height: 434)
                                                .cornerRadius(20)
                                                .padding()
                                        }
                                    }
                                } else {
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 330, height: 434)
                                            .foregroundStyle(Color(.gray).opacity(0.6))
                                            .cornerRadius(20)
                                            .padding()
                                        
                                        Image("Lock") // صورة القفل
                                    }
                                }
                            }
                            .contentMargins(50, for: .scrollContent)
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}
