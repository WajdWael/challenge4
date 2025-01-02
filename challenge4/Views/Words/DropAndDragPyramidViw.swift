//
//  DropAndDragPyramidViw.swift
//  Baraem Al-Lugha
//
//  Created by Wajd Wael on 24/06/1446 AH.
//
import SwiftUI
import AVFoundation

struct DragAndDropPyramidView: View {
   // @Binding var currentWordIndex: Int
    @Binding var completedWords: [Bool]
    @Binding var completedLetters: [Bool]
    @State private var droppedParts: [String?] = [nil, nil, nil, nil]
    @State private var isPartCorrect: [Bool] = [false, false, false, false]

    @ObservedObject var child : Child
    @Binding var isActivityCompleted: Bool
    var isLocked: Bool
    
    @State private var navigateToHomePage = false  // Flag to trigger navigation
    @State private var showCompletionPopup = false // Flag to show the completion popup
    
    let word: Word
    var wordParts: [String] {
        let word = words[child.currentWordIndex]
        return splitWord(word.word)
    }

    @State private var audioPlayer: AVAudioPlayer?
    
    
    var body: some View {
        
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
                    
                    Text("اسحب الأجزاء إلى الأماكن الصحيحة")
                        .globalFont(size: 70)
                        .bold()
                        .padding()
                    
                    Spacer()
                }
                
                HStack{
                    ZStack{
                        Spacer()
                        Rectangle().fill(Color("StichyNotesRectangle")).frame(width: 170, height: 500).cornerRadius(20)
                            
                        VStack {
                            ForEach(wordParts, id: \.self) { part in
                                if !droppedParts.contains(part) {
                                    DraggablePart(part: part)
                                }
                            }
                        }
                    }.padding()
                                        
                    VStack(spacing: 30) {
                        ForEach(0..<wordParts.count, id: \.self) { index in
                            ZStack {
                                Image("part\(index + 1)")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 600, height: 100)
                                    
                                if let part = droppedParts[index] {
                                    Text(part)
                                        .globalFont(size: 60)
                                        .foregroundColor(isPartCorrect[index] ? .black : .red)
                                        .onAppear {playSound(for: "positiveEffect")}
                                }
                            }
                            .onDrop(of: [.text], isTargeted: nil) { providers in
                                handleDrop(providers: providers, at: index)
                            }
                        }
                    }
                }
                
                HStack {
                    NavigationLink(destination: PyramidView(
                        isActivityCompleted: $isActivityCompleted,
                        completedWords: $completedWords,
                        completedLetters: $completedLetters,
                        child: child,
                        isLocked:isLocked,
                        word: word
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
                    }.padding()
                    Spacer()
                    NavigationLink(destination: SandDrawView(
                        child:child, completedWords: $completedWords, completedLetters: $completedLetters, isActivityCompleted:$isActivityCompleted, isLocked:isLocked
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
                    }.padding()
                    .onTapGesture {
                        child.moveToNextLetter()
                    }
                    .padding()
                }
            }.onAppear{
                playSound(for: "رتب أجزاء الكلمة في الهرم")
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

    func handleDrop(providers: [NSItemProvider], at index: Int) -> Bool {
        if let provider = providers.first(where: { $0.canLoadObject(ofClass: String.self) }) {
            _ = provider.loadObject(ofClass: String.self) { item, _ in
                if let text = item {
                    DispatchQueue.main.async {
                        if text == wordParts[index] {
                            droppedParts[index] = text
                            isPartCorrect[index] = true
                        } else {
                            isPartCorrect[index] = false
                            // Animation to return the part to its original position
                        }
                    }
                }
            }
            return true
        }
        return false
    }
        
    // تشغيل الصوت لجزء معين
    func playSound(for part: String) {
        // اسم الملف الصوتي يجب أن يتطابق مع النص (part)
        if let soundURL = Bundle.main.url(forResource: part, withExtension: "m4a") {
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

struct DraggablePart: View {
    let part: String
    @State private var isDragging = false
    
    var body: some View {
        ZStack {
            Text(part)
                .globalFont(size: 60)
                .frame(width: 150, height: 80)
                .padding()
                .background(isDragging ? Color.gray : Color("StickyNoteColor"))
                .cornerRadius(10)
                .onDrag {
                    isDragging = false // Reset state when dragging starts
                    return NSItemProvider(object: part as NSString)
                }
                .gesture(
                    DragGesture()
                        .onChanged { _ in
                            isDragging = true // Highlight while dragging
                        }
                        .onEnded { _ in
                            isDragging = false // Reset highlight
                        }
                )
        }
    }
}
