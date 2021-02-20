// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

class GridLinesView: GameSceneUpdatableProtocol {
    let grid: Grid
    var gridLinesCreated = false
    let gridDimensionsPix: CGSize
    var horizontalLines = [SKSpriteNode]()
    var isShowingGridLines = false
    let linesPool: SpritePool
    var parentNode: SKNode
    var ynShowGridLines = Config.showGridLInes
    var verticalLines = [SKSpriteNode]()

    init(
        grid: Grid, gridDimensionsPix: CGSize,
        parentNode: SKNode, linesPool: SpritePool
    ) {
        self.grid = grid
        self.gridDimensionsPix = gridDimensionsPix
        self.linesPool = linesPool
        self.parentNode = parentNode

        if Config.showGridLInes { createGridLines() }
    }

    func update() { updateGridLines() }
}

private extension GridLinesView {

    func showGridLines(_ ynShowGridLines: Bool) {
        self.ynShowGridLines = ynShowGridLines
        gameScene.invalidateView(self)
    }

    func updateGridLines() {
        (horizontalLines + verticalLines).forEach { $0.isHidden = !ynShowGridLines }
    }
}

private extension GridLinesView {

    func createGridLines() {
        let halfW = grid.width / 2, halfH = grid.height / 2

        let xRange = -(halfW + 1)..<(halfW + 1)
        let yRange = -(halfH + 1)..<(halfH + 1)

        for x in xRange {
            let line = createGridLine(
                x: x, y: nil, zRotation: .pi / 2, spritePool: linesPool
            )

            horizontalLines.append(line)
        }

        for y in yRange {
            let line = createGridLine(
                x: nil, y: y, zRotation: 0, spritePool: linesPool
            )

            verticalLines.append(line)
        }

        showGridLines(true)
    }

    func createGridLine(
        x: Int?, y: Int?,
        zRotation: CGFloat, spritePool: SpritePool
    ) -> SKSpriteNode {
        let line = spritePool.makeSprite()
        line.color = .gray
        line.colorBlendFactor = 1
        line.zPosition = 2
        line.size.height = 2

        line.size.width = gridDimensionsPix.width
        if x != nil { line.size.width *= Config.xScaleToSquare }

        line.zRotation = zRotation

        let cellDimensionsPix = gridDimensionsPix / grid.size.asSize()

        // Shift the lines by half a cell in both dimensions so
        // we'll actually outline each cell rather than intersecting
        // in the center
        let xx = x == nil ? 0 : (CGFloat(x!) + 0.5) * cellDimensionsPix.width
        let yy = y == nil ? 0 : (CGFloat(y!) + 0.5) * cellDimensionsPix.height

        line.position = CGPoint(x: xx, y: yy)

        spritePool.attachSprite(line, to: parentNode)
        return line
    }
}
