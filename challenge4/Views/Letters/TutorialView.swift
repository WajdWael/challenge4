//
//  TutorialView.swift
//  challenge4
//
//  Created by Wajd Wael on 18/06/1446 AH.
//

import SwiftUI
import AVKit


struct TutorialView: View {
    @State private var isPuzzleViewPresented = false
    @State private var playCount = 0
    @Binding  var completedLetters: [Bool]
    @ObservedObject var child: Child
    @State private var isActivityCompleted = false
    
    private var player: AVPlayer? {
        let letter = letters[child.currentWordIndex]

        guard let url = Bundle.main.url(forResource: letter.videoTutorial, withExtension: "mp4") else {
            print("Error: Video file not found!")
            return nil
        }
        let player = AVPlayer(url: url)
        player.actionAtItemEnd = .none
        return player
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                VStack {
                    NavigationLink(destination: HomeViewLetters(
                        child: child, completedLetters: $completedLetters
                    )) {
                        Image(systemName: "house.circle")
                            .resizable()
                            .foregroundStyle(Color.orange)
                            .frame(width: 78, height: 78)
                    }
                    .padding(.top)  // Adjust the top padding as needed
                    .padding(.leading)  // Adjust the left padding as needed
                }
            }
            ZStack {
                // Video Player
                if let player = player {
                    VideoPlayer(player: player)
                        .frame(width: 600, height: 400)  // Add custom width and height for the frame
                        .background(Color("PrimaryColor"))
                        .cornerRadius(10)  // Optional: Add rounded corners
                        .border(Color.gray, width: 2)  // Optional: Add border around the video
                        .onAppear {
                            player.play()
                        }
                        .onDisappear {
                            player.pause()  // Pause video when leaving the view
                        }
                } else {
                    Text("Error: Video not found!")
                        .font(.title)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }

            VStack {
                NavigationLink(destination: ColoringView(
                    child: child, completedLetters: $completedLetters
                )) {
                    Image(systemName: "arrow.forward.circle")
                        .resizable()
                        .foregroundStyle(Color.orange)
                        .frame(width: 78, height: 78)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .globalFont(size: 150)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("PrimaryColor"))
        .ignoresSafeArea()
    }
}
