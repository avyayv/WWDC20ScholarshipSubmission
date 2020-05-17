import SpriteKit

public func getFootballSprite(width:CGFloat) -> SKShapeNode {
    var football = SKShapeNode(circleOfRadius: CGFloat(ballRadius))
    
    football.position = CGPoint(x: width/2, y: 2*CGFloat(ballRadius))
    football.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(ballRadius)) 
    
    football.physicsBody?.affectedByGravity = false
    football.fillColor = footballColor
    football.lineWidth = 0
    
    football.physicsBody?.restitution = 1
    football.physicsBody?.categoryBitMask = PhysicsStruct.Football
    football.physicsBody?.collisionBitMask = PhysicsStruct.PaddleLeft | PhysicsStruct.PaddleRight | PhysicsStruct.Background
    football.physicsBody?.contactTestBitMask = PhysicsStruct.PaddleLeft | PhysicsStruct.PaddleRight | PhysicsStruct.Goal | PhysicsStruct.Background
    football.physicsBody?.isDynamic = true
    football.physicsBody?.linearDamping = 0.0
    
    return football
}

public func getScoreLabel(width:CGFloat, height:CGFloat) -> SKLabelNode{
    var scoreLabel = SKLabelNode(text: "0")
    scoreLabel.position = CGPoint(x: width/2, y: height-2*CGFloat(scoreSize))
    scoreLabel.fontSize = CGFloat(scoreSize)
    return scoreLabel
}

public func getHSLabel(width:CGFloat, height:CGFloat) -> SKLabelNode{
    var highScoreLabel = SKLabelNode(text: "0")
    highScoreLabel.position = CGPoint(x: width/2, y: height-2*CGFloat(scoreSize)+2*CGFloat(highScoreSize))
    highScoreLabel.fontSize = CGFloat(highScoreSize)
    return highScoreLabel
}

public func getGoalPostSprite(width:CGFloat) -> SKSpriteNode {
    var goalPost = SKSpriteNode(imageNamed: "goal.png")
    goalPost.position = CGPoint(x: width/2, y: 500.0)
    goalPost.physicsBody = SKPhysicsBody(rectangleOf: goalPost.size)
    goalPost.physicsBody?.categoryBitMask = PhysicsStruct.Goal
    goalPost.physicsBody?.collisionBitMask = PhysicsStruct.Football
    goalPost.physicsBody?.contactTestBitMask = PhysicsStruct.Football
    goalPost.physicsBody?.isDynamic = false
    goalPost.physicsBody?.affectedByGravity = false
    goalPost.zPosition = -1
    return goalPost
}

public func getDefenderSprite(width:CGFloat, height:CGFloat) -> SKShapeNode {
    var defender = SKShapeNode(rect: CGRect(x: width/2-CGFloat(defenderWidth/2), y: height/2-CGFloat(defenderHeight/2), width: CGFloat(defenderWidth), height: CGFloat(defenderHeight)))
    defender.fillColor = defenderColor
    defender.alpha = CGFloat(defenderOpacity)
    defender.lineWidth = 0
    defender.physicsBody = SKPhysicsBody(edgeLoopFrom: defender.frame)
    defender.physicsBody?.categoryBitMask = PhysicsStruct.Defense
    defender.physicsBody?.collisionBitMask = PhysicsStruct.Football
    defender.physicsBody?.contactTestBitMask = PhysicsStruct.Football
    defender.physicsBody?.isDynamic = false
    defender.physicsBody?.affectedByGravity = false
    defender.run(defenderSequence)
    return defender
}

public func getPaddle(width:CGFloat, left:Bool) -> SKShapeNode {
    var xCoord: CGFloat?
    if left {
        xCoord = 0
    } else {
        xCoord = CGFloat(width)-CGFloat(paddleWidth)
    }
    var paddleRect = CGRect(x: Double(xCoord!), y: paddleStartY, width: paddleWidth, height: paddleHeight)
    var paddle = SKShapeNode(rect: paddleRect)
    paddle.physicsBody = SKPhysicsBody(edgeLoopFrom: paddleRect)
    paddle.physicsBody?.affectedByGravity = false
    if left {
        paddle.physicsBody?.categoryBitMask = PhysicsStruct.PaddleLeft
        paddle.run(leftSequence)
    }else{
        paddle.physicsBody?.categoryBitMask = PhysicsStruct.PaddleRight
        paddle.run(rightSequence)
    }
    paddle.physicsBody?.collisionBitMask = PhysicsStruct.Football
    paddle.physicsBody?.contactTestBitMask = PhysicsStruct.Football
    paddle.physicsBody?.restitution = 1
    paddle.physicsBody?.isDynamic = false
    paddle.fillColor = .gray
    paddle.lineWidth = 0
    return paddle
}
