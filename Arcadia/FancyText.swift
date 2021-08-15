//
//  FancyText.swift
//  Arcadia
//
//  Created by Ravi Tripathi on 15/08/21.
//

import SwiftUI

struct FancyText: View {
    @State var number = 1
    var body: some View {
        VStack {
            Text("\(number)")
              .font(.largeTitle)
              .frame(width: 200, height: 200)
              .transition(.opacity)
//              .id("MyTitleComponent \(number)")
        }.onAppear {
            infiniteTimer()
        }
    }
    
    func infiniteTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            number += 1
            infiniteTimer()
        }
    }
}

struct FancyText_Previews: PreviewProvider {
    static var previews: some View {
        FancyText()
    }
}
