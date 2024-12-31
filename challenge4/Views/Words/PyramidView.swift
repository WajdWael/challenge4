//
//  PyramidView.swift
//  challenge4
//
//  Created by Wajd Wael on 18/06/1446 AH.
//

import SwiftUI
import AVFoundation

struct PyramidView: View {
    //@Binding var currentWordIndex: Int
    @Binding var isActivityCompleted: Bool
    @Binding var completedWords: [Bool]
    @Binding var completedLetters: [Bool]

    @State private var audioPlayer: AVAudioPlayer?
    @ObservedObject var child : Child
    
    let word : Word
    
    var body: some View {
        let word = words[child.currentWordIndex]
        let wordParts = splitWord(word.word)

        ZStack {
            Color("PrimaryColor").edgesIgnoringSafeArea(.all)

            VStack {
                Text("قسم الكلمة: \(word.word)")
                    .globalFont(size: 70)
                    .bold()

                VStack {
                    ForEach(0..<wordParts.count, id: \.self) { index in
                        ZStack {
                            Image("part\(index + 1)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 600, height: 100)

                            Text(wordParts[index])
                                .globalFont(size: 60)
                        }
                    }
                }
                .padding()

                NavigationLink(destination: DragAndDropPyramidView(
                    completedWords: $completedWords, completedLetters: $completedLetters, child:child, isActivityCompleted:$isActivityCompleted
                )) {
                    Image(systemName: "arrow.forward.circle")
                        .resizable()
                        .foregroundStyle(Color.orange)
                        .frame(width: 78, height: 78)
                }
            }.onAppear{
                playSound(for: "اضغط على أجزاء الهرم لسماع النطق")
            }
            
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        
    }

    func splitWord(_ word: String) -> [String] {
        var parts: [String] = []
        for i in 1...word.count {
            let index = word.index(word.startIndex, offsetBy: i)
            parts.append(String(word[word.startIndex..<index]))
        }
        return parts
    }
    
    
    // تشغيل الصوت لجزء معين
    func playSound(for part: String) {
        // اسم الملف الصوتي يجب أن يتطابق مع النص (part)
        if let soundURL = Bundle.main.url(forResource: part, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Error playing sound for \(part): \(error.localizedDescription)")
            }
        } else {
            print("Sound file for \(part) not found.")
        }
    }
}
