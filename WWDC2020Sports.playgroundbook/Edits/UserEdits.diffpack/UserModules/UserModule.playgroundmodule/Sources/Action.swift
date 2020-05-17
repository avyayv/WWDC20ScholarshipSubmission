import SpriteKit
var moveUp = SKAction.moveTo(y: CGFloat(paddleStartY+paddleTranslationMagnitude-paddleHeight/2), duration: paddleTranslationTime)
var moveDown = SKAction.moveTo(y: CGFloat(paddleStartY-2*paddleTranslationMagnitude-paddleHeight/2), duration: paddleTranslationTime)

var leftSequence = SKAction.repeatForever(SKAction.sequence([moveUp, moveDown]))
var rightSequence = SKAction.repeatForever(SKAction.sequence([moveDown, moveUp]))

var firstMoveLeft = SKAction.move(by: CGVector(dx: -defenderTranslationMagnitude, dy: 0), duration: defenderShiftTime)
var moveLeft = SKAction.move(by: CGVector(dx: -2*defenderTranslationMagnitude, dy: 0), duration: defenderShiftTime)
var moveRight = SKAction.move(by: CGVector(dx: 2*defenderTranslationMagnitude, dy: 0), duration: defenderShiftTime)
var regularDefenderSequence = SKAction.repeatForever(SKAction.sequence([moveRight, moveLeft]))
var defenderSequence = SKAction.sequence([firstMoveLeft, regularDefenderSequence])


