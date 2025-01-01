//
//  HomeViewLetters.swift
//  Baraem Al-Lugha
//
//  Created by Wajd Wael on 23/06/1446 AH.
//

//import SwiftUI
//
//struct HomeViewLetters: View {
//    @ObservedObject var child: Child
//    @Binding var completedLetters: [Bool]
//
//    var body: some View {
//        NavigationStack {
//            GeometryReader { geometry in
//                ZStack {
//                    // Background and Character
//                    Image("Charchter")
//                        .position(x: geometry.size.width * 1.0 - 270, y: geometry.size.height - 150)
//
//                    Image("Path___")
//                        .scaleEffect(1.5)
//                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
//
//                    VStack {
//                        // Navigation to Tutorial
//                        NavigationLink(destination: TutorialView(completedLetters: $completedLetters, child: child)) {
//                            Image("Brown_home")
//                        }
//                        .position(x: geometry.size.width * 0.3, y: geometry.size.height * 0.7)
//                        .scaleEffect(1)
//
//                        // Locked Words House
//                        Image("WordsHouseLocked")
//                            .position(x: geometry.size.width * 0.85, y: geometry.size.height * -0.18)
//                    }
//
//                    // Display Current Letter Status
//                    VStack {
//                        if letters[child.currentLetterIndex].isCompleted {
//                            ZStack {
//                                Circle()
//                                    .fill(Color.red)
//                                    .frame(width: 100, height: 100)
//                                    .shadow(color: Color.black, radius: 12)
//
//                                Text(letters[child.currentLetterIndex].letter) // Dynamically fetched word
//                                    .font(.largeTitle)
//                                    .foregroundColor(.white)
//                                    .bold()
//                            }
//                        }
//                    }
//                    .position(x: geometry.size.width / 2, y: geometry.size.height * 0.1) // Adjust position for visibility
//                }
//            }
//            .navigationBarBackButtonHidden(true)
//            .globalFont(size: 150)
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(Color("PrimaryColor"))
//            .ignoresSafeArea()
//        }
//    }
//}
//
////struct HomeViewLetters: View {
////    @ObservedObject var child: Child
////    @Binding var completedLetters: [Bool]
////
////    var body: some View {
////        NavigationStack {
////            GeometryReader { geometry in
////                ZStack {
////                    Image("Charchter")
////                        .position(x: geometry.size.width * 1.0 - 270, y: geometry.size.height - 150)
////
////                    Image("Path___")
////                        .scaleEffect(1.5)
////                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
////                    
////                    VStack {
////                        NavigationLink(destination: TutorialView(completedLetters: $completedLetters, child: child)) {
////                            Image("Brown_home")
////                        }.position(x: geometry.size.width * 0.3, y: geometry.size.height * 0.7)
////                            .scaleEffect(1)
////                        
////                        Image("WordsHouseLocked")
////                            .position(x: geometry.size.width * 0.85, y: geometry.size.height * -0.18)
////                    }
////                }
////            }
////            .navigationBarBackButtonHidden(true)
////            .globalFont(size: 150)
////            .frame(maxWidth: .infinity, maxHeight: .infinity)
////            .background(Color("PrimaryColor"))
////            .ignoresSafeArea()
////        }
////        VStack {
////            if letters[child.currentLetterIndex].isCompleted {
////                ZStack {
////                    Circle()
////                        .fill(Color.red)
////                        .frame(width: 100, height: 100)
////                        .shadow(color: Color.black, radius: 12)
////                    
////                    Text(letters[child.currentLetterIndex].letter) // Use the dynamically fetched word
////                        .font(.largeTitle)
////                        .foregroundStyle(Color(.white))
////                        .bold()
////                }
////            }
////        }
////
////    }
////}
////VStack {
////    // Display current letter's status
////    Text("Current Letter: \(letters[child.currentLetterIndex].letter)")
////        .font(.title)
////        .padding()
//
////    if letters[child.currentLetterIndex].isCompleted {
////        Text("This letter is completed!")
////            .foregroundColor(.green)
////            .font(.headline)
////    }
//
////    NavigationLink(destination: TutorialView(completedLetters: $completedLetters, child: child)) {
////        Image("Brown_home")
////    }
////    .position(x: geometry.size.width * 0.3, y: geometry.size.height * 0.7)
////    .scaleEffect(1)
//
////    Image("WordsHouseLocked")
////        .position(x: geometry.size.width * 0.85, y: geometry.size.height * -0.18)
////kkk
