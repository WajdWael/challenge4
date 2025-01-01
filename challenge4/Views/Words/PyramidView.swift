//
//  PyramidView.swift
//  challenge4
//
//  Created by Wajd Wael on 18/06/1446 AH.
//

import SwiftUI
import AVFoundation

struct PyramidView: View {
    @Binding var isActivityCompleted: Bool
    @Binding var completedWords: [Bool]
    @Binding var completedLetters: [Bool]

    @State private var audioPlayer: AVAudioPlayer?
    @ObservedObject var child : Child
    var isLocked: Bool

    let word : Word
    
    var body: some View {
        let word = words[child.currentWordIndex]
        let wordParts = splitWord(word.word)

        ZStack {
            Color("PrimaryColor").edgesIgnoringSafeArea(.all)

            VStack {
                HStack{
                    NavigationLink(destination: New_Home_Page(child: child, completedWords:$completedWords, completedLetters: $completedLetters, isLocked: isLocked)) {
                        
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
                    
                    Text("قسم الكلمة: \(word.word)")
                        .globalFont(size: 70)
                        .bold()
                        .padding()
                    
                    Spacer()
                }.padding()
                
                Spacer()


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

                HStack {
                    NavigationLink(destination: FlashCardView(
                        child: child,
                        isActivityCompleted: $isActivityCompleted,
                        completedWords: $completedWords,
                        completedLetters: $completedLetters,
                        isLocked:isLocked
                    )) {
                        Image(systemName: "arrowshape.right.fill")
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
                    Spacer()
                    NavigationLink(destination: DragAndDropPyramidView(
                        completedWords: $completedWords, completedLetters: $completedLetters, child:child, isActivityCompleted:$isActivityCompleted, isLocked:isLocked, word: word
                    )) {
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
