// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

class GridCellViewFactory {
    let backgroundsPool: SpritePool
    let grid: Grid
    let parentNode: SKNode
    let pixPerCellSide: CGFloat

    init(
        grid: Grid, parentNode: SKNode,
        cellDimensionsPix: CGSize, backgroundsPool: SpritePool
    ) {
        self.backgroundsPool = backgroundsPool
        self.grid = grid
        self.parentNode = parentNode
        self.pixPerCellSide = cellDimensionsPix.width
    }

    func makeView(at gridPosition: GridPoint) -> GridCellView {
        let cellBackground = backgroundsPool.makeSprite()
        backgroundsPool.attachSprite(cellBackground, to: parentNode)

        let scenePosition = gridPosition.asPoint() * pixPerCellSide

        return GridCellView(at: scenePosition, cellBackground: cellBackground)
    }
}

struct GridCellView {
    let cellBackground: SKSpriteNode
    var scenePosition: CGPoint!

    init(at scenePosition: CGPoint, cellBackground: SKSpriteNode) {
        self.cellBackground = cellBackground
        self.scenePosition = scenePosition
    }
}
