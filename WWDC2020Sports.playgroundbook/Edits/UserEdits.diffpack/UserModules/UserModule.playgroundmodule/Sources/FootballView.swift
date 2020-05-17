import SpriteKit
import Foundation
import CoreGraphics
public func displayFootballView() -> SKView{
    let scene = FootballScene(size: CGSize(width:500, height:750))
    let skView = SKView()
    skView.presentScene(scene)
    skView.showsFPS = true
    return skView
}
