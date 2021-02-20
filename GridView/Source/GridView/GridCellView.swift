// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

class GridCellViewFactory {
    let backgroundsPool: SpritePool
    let cellDimensionsPix: CGSize
    let grid: Grid
    let parentNode: SKNode

    init(
        grid: Grid, parentNode: SKNode,
        cellDimensionsPix: CGSize, backgroundsPool: SpritePool
    ) {
        self.backgroundsPool = backgroundsPool
        self.cellDimensionsPix = cellDimensionsPix
        self.grid = grid
        self.parentNode = parentNode
    }

    func makeView(at gridPosition: GridPoint) -> GridCellView {
        let cellBackground = backgroundsPool.makeSprite()
        backgroundsPool.attachSprite(cellBackground, to: parentNode)

        cellBackground.size = cellDimensionsPix * 0.95
        cellBackground.color = .init(calibratedWhite: 0.2, alpha: 1.0)

        let scenePosition = gridPosition.asPoint() * cellDimensionsPix.asPoint()

        return GridCellView(at: scenePosition, cellBackground: cellBackground)
    }
}

struct GridCellView {
    let cellBackground: SKSpriteNode
    var scenePosition: CGPoint!

    init(at scenePosition: CGPoint, cellBackground: SKSpriteNode) {
        self.cellBackground = cellBackground
        self.scenePosition = scenePosition
        self.cellBackground.position = scenePosition
    }
}
