// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

var grid: Grid!

@main
struct GridViewApp: App {
    init() {
        grid = Grid(
            size: Config.gridSize, cellLayoutType: .fullGrid,
            cellFactory: SomeGridCellFactory()
        )
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(
                    width: Config.mainWindowWidth,
                    height: Config.mainWindowWidth * Config.xScaleToSquare
                )
        }
    }
}
