//
//  DotsMatchingModel.swift
//  challenge4
//
//  Created by Wajd Wael on 18/06/1446 AH.
//

import SwiftData
import Foundation

@Model class DotsMatchingModel {
    var id: UUID
    var dotImage: String    // The image representing the dot pattern
    var isCompleted: Bool    // Whether the dots matching is done or not
    
    init(id: UUID, dotImage: String, isCompleted: Bool) {
        self.id = id
        self.dotImage = dotImage
        self.isCompleted = isCompleted
    }
}
