// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

class GridView {
    let cellDimensionsPix: CGSize
    let cellViews: [GridCellView]
    let grid: Grid
    var gridLinesCreated = false
    let gridDimensionsPix: CGSize
    var horizontalLines = [SKSpriteNode]()
    var invalidatedCells = [GridCellView]()
    let linesPool: SpritePool
    let parentNode: SKNode
    var verticalLines = [SKSpriteNode]()

    init(
        _ parentNode: SKNode,  _ grid: Grid, _ gridDimensionsPix: CGSize,
        _ backgroundsPool: SpritePool, _ linesPool: SpritePool
    ) {
        self.parentNode = parentNode
        self.grid = grid
        self.gridDimensionsPix = gridDimensionsPix
        self.linesPool = linesPool

        cellDimensionsPix = gridDimensionsPix / grid.size.asSize()

        let cellViewFactory =
            GridCellViewFactory(
                grid: grid, parentNode: parentNode,
                cellDimensionsPix: cellDimensionsPix,
                backgroundsPool: backgroundsPool
            )

        self.cellViews = grid.makeIterator().map {
            cellViewFactory.makeView(at: $0.gridPosition)
        }

        if Config.showGrid {
            if !gridLinesCreated {
                createGridLines()
                gridLinesCreated = true
            }

            showGrid(true)
        }
    }

    func getScenePosition(from gridPosition: GridPoint) -> CGPoint {
        let index = grid.cellIndex(at: gridPosition)

        return cellViews[index].scenePosition /
                CGPoint(x: 1, y: Config.aspectRatioOfRobsMacbookPro)
    }

    func invalidateCell(_ cell: GridCellView) {
        invalidatedCells.append(cell)
    }

    func showGrid(_ show: Bool) {
        guard Config.showGrid else { return }
        (horizontalLines + verticalLines).forEach { $0.isHidden = !show }
    }

    func updateGridView() {
        
    }
}

private extension GridView {

    func createGridLine(
        x: Int?, y: Int?,
        zRotation: CGFloat, spritePool: SpritePool
    ) -> SKSpriteNode {
        let line = spritePool.makeSprite()
        line.color = .red
        line.colorBlendFactor = 1
        line.zPosition = 2
        line.size.width = gridDimensionsPix.width
        line.size.height = 2

        line.zRotation = zRotation

        // Shift the lines by half a cell in both directions so
        // we'll actually outline each cell rather than intersecting
        // in the center
        let xx = x == nil ? 0 : (CGFloat(x!) + 0.5) * cellDimensionsPix.width
        let yy = y == nil ? 0 : (CGFloat(y!) - 0.5) * cellDimensionsPix.height

        line.position = CGPoint(x: xx, y: yy)

        spritePool.attachSprite(line, to: parentNode)
        return line
    }

    func createGridLines() {
        let halfW = grid.width / 2, halfH = grid.height / 2

        let xRange = -(halfW + 1)..<(halfW + 1)
        let yRange = -(halfH + 1)..<(halfH + 1)

        for x in xRange {
            let line = createGridLine(
                x: x, y: nil, zRotation: .pi / 2, spritePool: linesPool
            )

            line.color = .green

            horizontalLines.append(line)
        }

        for y in yRange {
            let line = createGridLine(
                x: nil, y: y, zRotation: 0, spritePool: linesPool
            )

            line.color = .orange

            verticalLines.append(line)
        }
    }
}
