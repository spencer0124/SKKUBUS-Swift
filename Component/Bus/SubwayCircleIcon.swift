//
//  CircleIcon.swift
//  skkumap
//
//  Created by 조승용 on 2024/01/02.
//

import Foundation
import SwiftUI

struct CircleIcon: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.system(size: 8, weight: .bold))
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 3, leading: 3, bottom: 4, trailing: 3))
            .background(Circle().fill(Color.init(hex: 0xFF00A9E0)))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CircleIcon(text: "4")
    }
}

