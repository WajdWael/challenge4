//
//  PyramidModel.swift
//  challenge4
//
//  Created by Wajd Wael on 18/06/1446 AH.
//

import SwiftData
import Foundation
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
