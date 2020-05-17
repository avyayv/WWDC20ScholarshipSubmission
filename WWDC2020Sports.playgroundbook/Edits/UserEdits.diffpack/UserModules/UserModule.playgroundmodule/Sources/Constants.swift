import Foundation
import UIKit
public let ballRadius = 14.5
public let footballColor = UIColor.brown
public let paddleWidth = 16.0
public let paddleHeight = 245.0
public let defenderColor = UIColor.red
public let defenderOpacity = 0.35
public let defenderWidth = 140
public let defenderHeight = 243

public let kScale = 0.8
public let finalPos = 650.0
public let scoreSize = 50.0 
public let paddleStartY = 250.0
public let paddleTranslationTime = 3.0
public let paddleTranslationMagnitude = 100.0
public let defenderShiftTime = 2.0
public let defenderTranslationMagnitude = 30.0
public let zPerDt = 0.8*kScale
public let goalZPos = 1.0
public let accelerationDueToGravity = 12.0*kScale
public let magnitudeOfSwipe = CGFloat(1000.0*kScale)
public let highScoreSize = 25.0
struct PhysicsStruct {
    static let Football: UInt32 = 0x1 << 1
    static let PaddleLeft : UInt32 = 0x1 << 2
    static let PaddleRight : UInt32 = 0x1 << 3
    static let Defense : UInt32 = 0x1 << 4
    static let Goal : UInt32 = 0x1 << 5
    static let Background : UInt32 = 0x1 << 6
}


