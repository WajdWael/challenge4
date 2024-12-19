//
//  challenge4App.swift
//  challenge4
//
//  Created by Wajd Wael on 18/06/1446 AH.
//

import SwiftUI
import SwiftData

@main
struct challenge4App: App {
    @Environment(\.modelContext) private var modelContext
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [TutorialModel.self])
                .onAppear {
                    seedTutorialData()
                }
        }
    }
    private func seedTutorialData() {
        do {
            // Use a fetch request to check if tutorials already exist
            let fetchDescriptor = FetchDescriptor<TutorialModel>()
            let existingTutorials = try modelContext.fetch(fetchDescriptor)
            
            if !existingTutorials.isEmpty {
                return  // Exit if data already exists
            }
            
            // Create a new tutorial entry
            let tutorial = TutorialModel(
                id: UUID(),
                videoURL: URL(string: "A-ar-tutorial")!,  // Just the name of the video file
                images: ["image1.png", "image2.png"],     // Example image names
                audioURL: URL(string: "audio1.mp3")!      // Example audio URL
            )
            modelContext.insert(tutorial)
            try modelContext.save()  // Save the context
        } catch {
            print("Error seeding data: \(error.localizedDescription)")
        }
    }
    
    private func seedPuzzleData() {
        do {
            // Use a fetch request to check if puzzle data already exists
            let fetchDescriptor = FetchDescriptor<PuzzleModel>()
            let existingPuzzles = try modelContext.fetch(fetchDescriptor)
            
            if !existingPuzzles.isEmpty {
                return  // Exit if puzzle data already exists
            }
            
            // Create a new puzzle entry
            let puzzle = PuzzleModel(
                id: UUID(),
                puzzlePieces: ["tile1.svg", "tile2.svg", "tile3.svg", "tile4.svg", "tile5.svg", "tile6.svg"],  // Example puzzle piece image names
                isCompleted: false  // Set whether the puzzle is completed
            )
            
            // Insert the puzzle model into the context
            modelContext.insert(puzzle)
            
            // Save the context
            try modelContext.save()
        } catch {
            print("Error seeding puzzle data: \(error.localizedDescription)")
        }
    }


}
