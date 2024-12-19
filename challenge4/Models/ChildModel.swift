//
//  ChildModel.swift
//  challenge4
//
//  Created by Wajd Wael on 18/06/1446 AH.
//

import SwiftData
import Foundation

@Model
class ChildModel {
    var id: UUID
    var name: String
    var age: Int
    var letters: [LetterModelMain] // Relationship to all letters
    var progress: Double // Overall progress (0-100%)
    
    init(name: String, age: Int, letters: [LetterModelMain], progress: Double) {
        self.id = UUID()
        self.name = name
        self.age = age
        self.letters = letters
        self.progress = progress
    }
    
    // Function to determine next screen based on age
    func nextScreen() -> String {
        if age == 5 || age == 6 {
            return "Letters"
        } else {
            return "Select Age" // or other screens
        }
    }
    
    func updateChildProgress() {
        let totalProgress = letters.reduce(0.0) { (result, letter) in
            result + letter.progress
        }
        
        let averageProgress = totalProgress / Double(letters.count)
        
        // Update the child progress
        self.progress = averageProgress
    }
}
