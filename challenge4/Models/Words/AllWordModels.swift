//
//  AllWordModels.swift
//  challenge4
//
//  Created by Alaa Emad Alhamzi on 18/06/1446 AH.
//

import Foundation
import SwiftData

@Model
class FlashCard {
    var text: String                     // Text displayed on the flashcard
    var textBackgroundColor: String      // Background color for the text side
    var imageBackgroundColor: String     // Background color for the image side
    var textColor: String                // Text color

    init(textBackgroundColor: String, imageBackgroundColor: String, textColor: String, text: String) {
        self.textBackgroundColor = textBackgroundColor
        self.imageBackgroundColor = imageBackgroundColor
        self.textColor = textColor
        self.text = text
    }
}


@Model
class Word {
    var flashcard: FlashCard             // Flashcard for the word
    var pyramid: [PyramidParts] = []     // Pyramid steps for decoding the word

    init(flashcard: FlashCard, pyramid: [PyramidParts] = []) {
        self.flashcard = flashcard
        self.pyramid = pyramid
    }
}

// MARK: - PyramidParts Model
@Model
class PyramidParts {
    var text: String                     // Text for the pyramid part
    var pyramidImage: String             // Path to the image representing the part
    var voiceFile: String                // Path to the voice file for pronunciation

    init(text: String, pyramidImage: String, voiceFile: String) {
        self.text = text
        self.pyramidImage = pyramidImage
        self.voiceFile = voiceFile
    }
}

// MARK: - DragToPyramid Model
@Model
class DragToPyramid {
    var pyramidParts: [PyramidParts]     // Pyramid parts to drag and drop
    var textBoxes: [String]              // Text boxes for drag targets
    var isCorrectPosition: Bool = false // Tracks if the items are correctly positioned

    init(pyramidParts: [PyramidParts], textBoxes: [String], isCorrectPosition: Bool = false) {
        self.pyramidParts = pyramidParts
        self.textBoxes = textBoxes
        self.isCorrectPosition = isCorrectPosition
    }
}

