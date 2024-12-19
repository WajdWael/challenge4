//
//  GlobalFontModifier.swift
//  challenge4
//
//  Created by Wajd Wael on 18/06/1446 AH.
//

import SwiftUI

extension View {
    func globalFont(size: CGFloat) -> some View {
        self.font(Font.custom("Maqroo-Regular", size: size))
    }
}
