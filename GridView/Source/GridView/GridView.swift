// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

class GridView: GameSceneUpdatableProtocol {
    let backgroundsPool: SpritePool
    let cellDimensionsPix: CGSize
    let cellViews: [GridCellView]
    let grid: Grid
    let gridDimensionsPix: CGSize
    let gridLinesView: GridLinesView?
    var invalidatedCells = [GridCellView]()
    let linesPool: SpritePool
    let parentNode: SKNode

    init(_ parentNode: SKNode,  _ grid: Grid, _ gridDimensionsPix: CGSize) {
        self.parentNode = parentNode
        self.grid = grid
        self.gridDimensionsPix = gridDimensionsPix

        cellDimensionsPix = gridDimensionsPix / grid.size.asSize()

        self.backgroundsPool = SpritePool("Markers", "rectangle-solid", grid.area)
        self.linesPool = SpritePool("Markers", "rectangle-solid", grid.area)

        let cellViewFactory =
            GridCellViewFactory(
                grid: grid, parentNode: parentNode,
                cellDimensionsPix: cellDimensionsPix,
                backgroundsPool: backgroundsPool
            )

        self.cellViews = grid.makeIterator().map {
            cellViewFactory.makeView(at: $0.gridPosition)
        }

        if Config.showGridLInes {
            gridLinesView = GridLinesView(
                grid: grid, gridDimensionsPix: gridDimensionsPix,
                parentNode: parentNode, linesPool: linesPool
            )
        } else { gridLinesView = nil }
    }

    func getScenePosition(from gridPosition: GridPoint) -> CGPoint {
        let index = grid.cellIndex(at: gridPosition)

        return cellViews[index].scenePosition /
                CGPoint(x: 1, y: Config.aspectRatioOfRobsMacbookPro)
    }

    func invalidateCell(_ cell: GridCellView) {
        invalidatedCells.append(cell)
    }

    func update() {
    }
}
