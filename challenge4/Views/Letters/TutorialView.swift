//
//  TutorialView.swift
//  challenge4
//
//  Created by Wajd Wael on 18/06/1446 AH.
//
import SwiftUI
import AVKit

struct TutorialView: View {
    @State private var isPuzzleViewPresented = false  // To trigger navigation
    @State private var playCount = 0  // To count video playbacks

    // Video Player setup
    private var player: AVPlayer? {
        guard let url = Bundle.main.url(forResource: "A-ar-tutorial", withExtension: "mp4") else {
            print("Error: Video file not found!")
            return nil
        }
        let player = AVPlayer(url: url)
        player.actionAtItemEnd = .none  // Prevent stopping when the video ends
        return player
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Video Player
                if let player = player {
                    VideoPlayer(player: player)
                        .frame(width: UIScreen.main.bounds.width * 1.2,
                               height: UIScreen.main.bounds.height * 1.5)
                        .background(Color.black)
                        .edgesIgnoringSafeArea(.all)  // Fill the entire screen
                        .onAppear {
                            player.play()  // Auto-play the video
                            addRepeatNotification(for: player)  // Handle playback and navigation
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
            .navigationDestination(isPresented: $isPuzzleViewPresented) {
                PuzzleView()  // Navigate to the PuzzleView
            }
        }
    }

    // Handle looping and navigation after 3 plays
    private func addRepeatNotification(for player: AVPlayer) {
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { _ in
            playCount += 1  // Increment the play count
            if playCount >= 3 {
                isPuzzleViewPresented = true  // Navigate after 3 plays
            } else {
                player.seek(to: .zero)  // Restart the video
                player.play()  // Play again
            }
        }
    }
}

#Preview {
    TutorialView()
}
