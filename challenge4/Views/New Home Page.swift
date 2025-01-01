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
                                        .font(.system(size: 48, weight: .bold))
                                        .foregroundColor(.black)
                                }
                                .scaleEffect(isAnimatingFirstHome ? 1.1 : 1.0)
                            }
                            
                            if completedLetters.allSatisfy({ $0 }) {
                                NavigationLink(destination: Words_Levels(child: child, completedWords: $completedWords, completedLetters: $completedLetters, isActivityCompleted: $isActivityCompleted)) {
                                    VStack {
                                        Image("Word_home")
                                            .resizable()
                                            .frame(width: 713, height: 673)
                                        Text("بيت الكلمات")
                                            .font(.system(size: 48, weight: .bold))
                                            .foregroundColor(.black)
                                    }
                                }
                            } else if isLocked {
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
    
    // Function to clear the database
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
