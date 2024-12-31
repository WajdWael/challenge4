//
//  New Age View.swift
//  Baraem Al-Lugha
//
//  Created by Alaa Emad Alhamzi on 30/06/1446 AH.
//

import SwiftUI

struct New_Age_View: View {
    
    @State private var selectedAge: Int?
    @State private var child: Child?
    @State private var completedWords: [Bool] = [false, false, false]
    @State private var completedLetters: [Bool] = [false, false, false]
    @State private var isLocked = false
    
    let ages = [
        "Ballon_age5",
        "Ballon_age6",
        "Ballon_age7",
        "Ballon_age8"
    ]
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                Text("اختر عمرك")
                    .globalFont(size: 130)
                
                HStack {
                    
                    ForEach(ages, id: \.self) { age in
                        
                        let destinationLetters = New_Home_Page(child: Child(age: age, currentWordIndex: 0, currentLevelPrograss : 0, currentLetterIndex: 0), completedWords:$completedWords, completedLetters: $completedLetters, isLocked: isLocked)
                        
                        let destinationWords = New_Home_Page(child: Child(age: age, currentWordIndex: 0, currentLevelPrograss : 0, currentLetterIndex: 0), completedWords: $completedWords, completedLetters: $completedLetters, isLocked: isLocked)
                        
                        if (age == "Ballon_age5" || age == "Ballon_age6"){
                            NavigationLink (
                                destination: destinationLetters
                            ) {
                                Image(age)
                            }.offset(y: -10)
                        } else {
                            NavigationLink (
                                destination: destinationWords
                            ) {
                                Image(age)
                            }.offset(y: -10)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("PrimaryColor"))
            .ignoresSafeArea()
        }
    }
}

// Preview
#Preview {
    New_Age_View()
}

