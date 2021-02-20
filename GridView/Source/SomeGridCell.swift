// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

class SomeGridCellFactory: GridCellFactoryProtocol {
    func makeCell(gridPosition: GridPoint) -> GridCellProtocol {
        SomeGridCell(gridPosition)
    }
}

class SomeGridCell: GridCellProtocol {
    static func cell(_ gridCell: GridCellProtocol) -> SomeGridCell {
        (gridCell as? SomeGridCell)!
    }

    var gridPosition: GridPoint

    init(_ gridPosition: GridPoint) {
        self.gridPosition = gridPosition
    }
}
