// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

enum Config {
    static let aspectRatioOfRobsMacbookPro: CGFloat = 2880 / 1800
    static let cellViewBackgrounds = true
    static let gridSize = GridSize(width: 5, height: 5)
    static let sceneWidthPix: CGFloat = 800
    static let showGridLInes = true
    static let xScaleToSquare = 1 / aspectRatioOfRobsMacbookPro

    static let sceneDimensionsPix =
        CGSize(width: sceneWidthPix, height: sceneWidthPix * xScaleToSquare)
}
