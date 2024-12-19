//
//  MainLetterModel.swift
//  challenge4
//
//  Created by Wajd Wael on 18/06/1446 AH.
//

import SwiftData
import Foundation

@Model
class LetterModelMain {
    var id: UUID
    var name: String
    var tutorial: TutorialModel
    var coloring: ColoringModel
    var puzzle: PuzzleModel
    var dotsMatching: DotsMatchingModel
    var progress: Double 
    
    init(name: String, tutorial: TutorialModel, coloring: ColoringModel, puzzle: PuzzleModel, dotsMatching: DotsMatchingModel, progress: Double) {
        self.id = UUID()
        self.name = name
        self.tutorial = tutorial
        self.coloring = coloring
        self.puzzle = puzzle
        self.dotsMatching = dotsMatching
        self.progress = progress
    }
}
