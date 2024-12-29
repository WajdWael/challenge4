//
//  ColorPickerView.swift
//  Baraem Al-Lugha
//
//  Created by Wajd Wael on 25/06/1446 AH.
//

import SwiftData
import SwiftUI

struct Chalk {
    var name: String
    var color: Color
}

struct ColorPickerView: View {
    @Binding var selectedColor: Color // Bind to update the selected color

    // Define the chalk colors
    let chalks: [Chalk] = [
        Chalk(name: "Black", color: .black),
        Chalk(name: "Red", color: .red),
        Chalk(name: "DarkPink", color: .pink),
        Chalk(name: "Green", color: .green),
        Chalk(name: "Brown", color: .brown),
        Chalk(name: "LightBlue2", color: .blue)
    ]

    var body: some View {
        VStack {
            HStack {
                ForEach(chalks, id: \.name) { chalk in
                    VStack {
                        // Use a circle with the color as background
                        Image(chalk.name)
                            .resizable()
                            
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .padding()
//                            ./*background*/(Circl/e().fill(chalk.color)) // Use the color directly
                            .scaleEffect(selectedColor == chalk.color ? 2 : 1.5) // Scale the selected color
                            .onTapGesture {
                                selectedColor = chalk.color // Set selected color
                            }
                    }
                }
            }
            .padding()

            // Display the selected color text
            Text("Selected Color")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }


}

