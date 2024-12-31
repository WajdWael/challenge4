import Foundation
import SwiftData

@Model
class Child: ObservableObject {
    var age: String
    var currentWordIndex: Int
    var currentLevelPrograss: Int
    var currentLetterIndex: Int

    init(age: String, currentWordIndex: Int, currentLevelPrograss: Int, currentLetterIndex: Int) {
        self.age = age
        self.currentWordIndex = currentWordIndex
        self.currentLevelPrograss = currentLevelPrograss
        self.currentLetterIndex = currentLetterIndex
    }

    func markCurrentLetterCompleted() {
        if currentLetterIndex < letters.count {
            letters[currentLetterIndex].isCompleted = true
        }
    }

    func moveToNextLetter() {
        markCurrentLetterCompleted()
        if currentLetterIndex < letters.count - 1 {
            currentLetterIndex += 1
        } else {
            print("All letters completed!")
        }
    }
}
