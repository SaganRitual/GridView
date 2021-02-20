// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

enum DisplayCycle: Int {
    case updateStarted, didFinishUpdate
    case evaluatingActions, didEvaluateActions
    case simulatingPhysics, didSimulatePhysics
    case applyingConstraints, didApplyConstraints
    case renderingScene
    case idle

    func isIn(_ state: DisplayCycle) -> Bool { return self.rawValue == state.rawValue }
    func isPast(_ milestone: DisplayCycle) -> Bool { return self.rawValue >= milestone.rawValue }
}

struct Display {
    static var displayCycle: DisplayCycle = .idle
}

protocol GameSceneUpdatableProtocol {
    func update()
}

var gameScene: GameScene!
var updatableViews = [GameSceneUpdatableProtocol]()

class GameScene: SKScene, SKSceneDelegate {
    private var tickCount = 0

    var readyToRun = false

    override init() {
        super.init(size: NSScreen.main!.frame.size)
        gameScene = self

        gameScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        gameScene.scaleMode = .fill
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GameScene {
    func updateViews() { updatableViews.forEach { $0.update() } }
}

extension GameScene {
    override func didMove(to view: SKView) {
        self.backgroundColor = .black

        view.showsFPS = true
        view.showsNodeCount = true

        readyToRun = true
    }

    override func update(_ currentTime: TimeInterval) {
        defer { Display.displayCycle = .evaluatingActions }
        Display.displayCycle = .updateStarted
        guard readyToRun else { return }

        updateViews()

        tickCount += 1
    }
}

extension GameScene {
    override func didEvaluateActions() {
        defer { Display.displayCycle = .simulatingPhysics }
        Display.displayCycle = .didEvaluateActions
    }

    override func didFinishUpdate() {
        defer { Display.displayCycle = .renderingScene }
        Display.displayCycle = .didFinishUpdate
    }

    override func didSimulatePhysics() {
        defer { Display.displayCycle = .applyingConstraints }
        Display.displayCycle = .didSimulatePhysics
    }
}
