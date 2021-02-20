// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct ContentView: View {
    let gameScene = GameScene(grid)

    var body: some View {
        SpriteView(scene: gameScene)
            .edgesIgnoringSafeArea([.bottom, .leading, .trailing])
            .padding(.trailing, 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
