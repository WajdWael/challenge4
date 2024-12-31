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
        let letterData = letters[child.currentLetterIndex]

        guard let url = Bundle.main.url(forResource: letterData.videoTutorial, withExtension: "mp4") else {
            print("Error: Video file not found!")
            return nil
        }
        let player = AVPlayer(url: url)
        player.actionAtItemEnd = .none
        return player
    }

    var body: some View {
        let letterData = letters[child.currentLetterIndex]

        NavigationStack {
        ZStack {
            Color("PrimaryColor").ignoresSafeArea()
            VStack {
                // Home Button
                HStack{
                    NavigationLink(destination: HomeViewLetters(child: child, completedLetters: $completedLetters)) {
                        Image(systemName: "house.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 81, height: 81)
                            .background(
                                RoundedRectangle(cornerRadius: 100)
                                    .fill(Color(red: 255 / 255, green: 195 / 255, blue: 63 / 255)) // Background color (#FFC33F)
                                    .shadow(color: Color(red: 255 / 255, green: 173 / 255, blue: 0 / 255), radius: 0, x: 5, y: 8)
                            )
                    }
                    Spacer()
                    
                    Text("شاهد المقطع، تعلم حرف \(letters[child.currentLetterIndex].letter)")
                        .globalFont(size: 80)
                    Spacer()
                }.padding()
                
                // View content
                ZStack {
                    if let player = player {
                        VideoPlayer(player: player)
                            .frame(width: 860, height: 484)
                            .background(Color("PrimaryColor"))
                            .cornerRadius(23)
                            .onAppear {
                                player.play()
                            }
                            .onDisappear {
                                player.pause()
                            }
                    } else {
                        Text("Error: Video not found!")
                            .font(.title)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                
                // Nav Buttons
                HStack {
                    Spacer()
                    NavigationLink(destination: ColoringView(child: child, completedLetters: $completedLetters)) {
                        Image(systemName: "arrowshape.left.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 81, height: 81) // Expand to fill horizontal space
                            .background(
                                RoundedRectangle(cornerRadius: 100)
                                    .fill(Color(red: 255 / 255, green: 195 / 255, blue: 63 / 255)) // Background color (#FFC33F)
                                    .shadow(color: Color(red: 255 / 255, green: 173 / 255, blue: 0 / 255), radius: 0, x: 5, y: 8)
                            )
                    }
                    .onTapGesture {
                        child.moveToNextLetter()
                    }
                    .padding()
                }
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .background(Color("PrimaryColor"))
        .ignoresSafeArea()
        }
    }
}
