// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

enum Config {
    static let aspectRatioOfRobsMacbookPro: CGFloat = 2880 / 1800
    static let cellViewBackgrounds = true
    static let gridSize = GridSize(width: 5, height: 5)
    static let mainWindowWidth: CGFloat = 400
    static let showGrid = true
    static let xScaleToSquare = 1 / aspectRatioOfRobsMacbookPro
}
