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
        guard let url = Bundle.main.url(forResource: "yaa__letter", withExtension: "mp4") else {
            print("Error: Video file not found!")
            return nil
        }
        let player = AVPlayer(url: url)
        player.actionAtItemEnd = .none
        return player
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Video Player
                if let player = player {
                    VideoPlayer(player: player)
                        .frame(width: 600, height: 600)
                        .background(Color("PrimaryColor"))
                        .edgesIgnoringSafeArea(.all)
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
                
                NavigationLink(destination: HomeViewLetters(
                    child: child, completedLetters: $completedLetters
                )) {
                    Image(systemName: "house.circle")
                        .resizable()
                        .foregroundStyle(Color.orange)
                        .frame(width: 78, height: 78)
                }
                NavigationLink(destination: PuzzleView(
                    child: child, completedLetters: $completedLetters
                )) {
                    Image(systemName: "arrow.forward.circle")
                        .resizable()
                        .foregroundStyle(Color.orange)
                        .frame(width: 78, height: 78)
                }

            }
        }
    }
}
