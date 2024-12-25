//
//  DropAndDragPyramidViw.swift
//  Baraem Al-Lugha
//
//  Created by Wajd Wael on 24/06/1446 AH.
//

import SwiftUI

struct DragAndDropPyramidView: View {

    @Binding var completedWords: [Bool]
    @Binding var completedLetters: [Bool]

    @State private var droppedParts: [String?] = [nil, nil, nil, nil]
    @State private var isPartCorrect: [Bool] = [false, false, false, false]
    @ObservedObject var child : Child
    @State private var navigateToHomePage = false
    @State private var showCompletionPopup = false
    
    var wordParts: [String] {
        let word = words[child.currentWordIndex]
        return splitWord(word.word)
    }

    var body: some View {
        ZStack {
            Color("PrimaryColor").edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("اسحب الأجزاء إلى الأماكن الصحيحة")
                    .globalFont(size: 60)
                    .bold()
                    .padding()
                
                HStack{
                
                    ZStack{
                        Spacer()
                        Rectangle().fill(Color("pryimadColor")).frame(width: 140, height: 400).cornerRadius(20)
                        
                        VStack {
                            ForEach(wordParts, id: \.self) { part in
                                if !droppedParts.contains(part) {
                                    DraggablePart(part: part)
                                }
                            }
                        }
                    }
                    VStack(spacing: 30) {
                        ForEach(0..<wordParts.count, id: \.self) { index in
                            ZStack {
                                Image("part\(index + 1)")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 600, height: 100)
                                
                                
                                if let part = droppedParts[index] {
                                    Text(part)
                                        
                                        .foregroundColor(isPartCorrect[index] ? .black : .red)
                                }
                            }
                            .globalFont(size: 60)
                            .onDrop(of: [.text], isTargeted: nil) { providers in
                                handleDrop(providers: providers, at: index)
                            }
                        }
                    }
                }
                
                NavigationLink(
                    destination: SandDrawView(child:child, completedWords: $completedWords, completedLetters: $completedLetters),
                    label: {
                        Image(systemName: "arrow.forward.circle")
                            .resizable()
                            .foregroundStyle(Color.orange)
                            .frame(width: 78, height: 78)
                    }
                )
                .padding()
            }
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
                        }
                    }
                }
            }
            return true
        }
        return false
    }
}

struct DraggablePart: View {
    let part: String
    var body: some View {
        ZStack{
            Text(part)
                .globalFont(size: 30)
//                .font(.headline)
                .frame(width: 50, height: 50)
                .padding()
                .background(Color("ProgressBarColor"))
                .cornerRadius(10)
                .onDrag {NSItemProvider(object: part as NSString)}
        }
    }
}
