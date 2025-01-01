//
//  New Home Page.swift
//  Baraem Al-Lugha
//
//  Created by Alaa Emad Alhamzi on 30/06/1446 AH.
//

import SwiftUI
import _SwiftData_SwiftUI


struct New_Home_Page: View {
    
    @Environment(\.modelContext) var context
    
    @ObservedObject var child: Child
    @State private var isAnimatingFirstHome = false
    @State private var isAnimatingSecondHome = false
    @Binding var completedWords: [Bool]
    @Binding var completedLetters: [Bool]
    @State private var isActivityCompleted = false
    var isLocked: Bool
    
    
    
    
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                
                
                VStack{
                    
                    
                    //For reset the database and displaying it
                    
                    //                    Button {
                    //                        resetDatabase()
                    //                    } label: {
                    //
                    //                        Text("Clear database")
                    //                            .font(.largeTitle)
                    //                            .foregroundStyle(Color.white)
                    //                            .frame(width: 70, height: 70)
                    //                            .background(Color.blue)
                    //                    }
                    //
                    //
                    //                    NavigationLink(destination: SwiftUIView()){
                    //
                    //                        Text("GO TO THE VIEW")
                    //                    }
                    
                    
                    Color("PrimaryColor").edgesIgnoringSafeArea(.all)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        
                        HStack {
                            
                            NavigationLink(destination: Letters_Levels(child:child, completedLetters:$completedLetters, completedWords:$completedWords, isLocked:isLocked)) {
                                Image("Brown_home")
                                    .resizable()
                                    .frame(width: 500, height: 500)
                                    .containerRelativeFrame(.horizontal, count: 2, spacing: 100)
                                    .scaleEffect(isAnimatingFirstHome ? 1.1 : 1.0)
                            }
                            
                            
                            if completedLetters.allSatisfy{$0} {
                                
                                NavigationLink(destination: Words_Levels(child:child, completedWords:$completedWords, completedLetters:$completedLetters, isActivityCompleted:$isActivityCompleted)) {
                                    Image("Bage_home")
                                        .resizable()
                                        .frame(width: 500, height: 500)
                                        .containerRelativeFrame(.horizontal, count: 2, spacing: 100)
                                    // .scaleEffect(isAnimatingFirstHome ? 1.1 : 1.0)
                                }
                            }
                                
                                
                                //                            }else{
                                //
                                //                                ZStack {
                                //                                    Image("Bage_home")
                                //                                        .resizable()
                                //                                        .frame(width: 500, height: 500)
                                //                                        .opacity(0.3)
                                //
                                //                                    Image(systemName: "lock.fill")
                                //                                        .foregroundColor(.red)
                                //                                        .frame(width: 500, height: 500)
                                //                                }
                                //
                                //
                                //                            }
                                
                                
                                if isLocked {
                                    
                                    ZStack {
                                        Image("Bage_home")
                                            .resizable()
                                            .frame(width: 500, height: 500)
                                            .opacity(0.3)
                                        
                                        Image(systemName: "lock.fill")
                                            .foregroundColor(.red)
                                            .frame(width: 500, height: 500)
                                    }
                                    
                                    
                                } else {
                                    NavigationLink(destination: Words_Levels(child:child, completedWords:$completedWords, completedLetters:$completedLetters, isActivityCompleted:$isActivityCompleted)) {
                                        Image("Bage_home")
                                            .resizable()
                                            .frame(width: 500, height: 500)
                                            .containerRelativeFrame(.horizontal, count: 2, spacing: 100)
                                        // .scaleEffect(isAnimatingFirstHome ? 1.1 : 1.0)
                                    }
                                }
                            
                        }
                        .navigationBarBackButtonHidden(true)
                    }
                }
            }
        }
        
    }
        //function clears the database
        private func resetDatabase() {
            do {
                let request = FetchDescriptor<Child>()
                let children = try context.fetch(request)
                for child in children {
                    context.delete(child)
                }
                try context.save()
                print("قاعدة البيانات تم تنظيفها.")
            } catch {
                print("خطأ أثناء تنظيف قاعدة البيانات: \(error.localizedDescription)")
            }
        }
    }

