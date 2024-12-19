//
//  FlashCardModel.swift
//  challenge4
//
//  Created by Wajd Wael on 18/06/1446 AH.
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

