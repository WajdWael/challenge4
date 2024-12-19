//
//  PuzzleModel.swift
//  challenge4
//
//  Created by Wajd Wael on 18/06/1446 AH.
//

import Foundation
import SwiftData

@Model
class PuzzleModel {
    var id: UUID
    var puzzlePieces: [String]  // List of puzzle piece image names
    var isCompleted: Bool        // Whether the puzzle is completed
    
    init(id: UUID, puzzlePieces: [String], isCompleted: Bool = false) {
        self.id = id
        self.puzzlePieces = puzzlePieces
        self.isCompleted = isCompleted
    }
}

