//
//  LettersViewModels.swift
//  challenge4
//
//  Created by Wajd Wael on 18/06/1446 AH.
//

import SwiftData
import Foundation

class LetterViewModel: ObservableObject {
    @Published var currentLetter: LetterModelMain
    @Published var progress: Double = 0.0

    init(letter: LetterModelMain) {
        self.currentLetter = letter
        self.progress = letter.progress
    }

    func completeColoring() {
        currentLetter.coloring.isCompleted = true
        updateProgress()
    }

    func completePuzzle() {
        currentLetter.puzzle.isCompleted = true
        updateProgress()
    }

    func completeDotsMatching() {
        currentLetter.dotsMatching.isCompleted = true
        updateProgress()
    }

    private func updateProgress() {
        var completedActivities = 0
        let totalActivities = 3  // Adjust if more activities are added

        if currentLetter.coloring.isCompleted {
            completedActivities += 1
        }
        if currentLetter.puzzle.isCompleted {
            completedActivities += 1
        }
        if currentLetter.dotsMatching.isCompleted {
            completedActivities += 1
        }

        progress = Double(completedActivities) / Double(totalActivities)
        currentLetter.progress = progress
    }
    
    
    // Example of navigation logic
    func goToNextActivity(currentActivity: String) -> String {
        switch currentActivity {
        case "Video":
            return "Letter Images"
        case "Letter Images":
            return "Coloring"
        case "Coloring":
            return "Puzzle"
        case "Puzzle":
            return "Home"
        default:
            return "Unknown"
        }
    }
}

