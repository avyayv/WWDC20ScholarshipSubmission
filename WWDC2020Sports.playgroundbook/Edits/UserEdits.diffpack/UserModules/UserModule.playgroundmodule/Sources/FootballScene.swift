import SpriteKit
import UIKit

class FootballScene: SKScene, SKPhysicsContactDelegate {
    var football = SKShapeNode()
    var leftPaddle = SKShapeNode()
    var rightPaddle = SKShapeNode()
    var goalPost = SKSpriteNode()
    var defender = SKShapeNode()
    var scoreLabel = SKLabelNode()
    var highScoreLabel = SKLabelNode()
    var score = 0
    var highScore = 0
    var startLocation: CGPoint?
    var startTime: TimeInterval?
    var movementVector: CGVector?
    var zAxis = 0.0
    var lastTime: TimeInterval?
    var kicking = false
    var inContact = false
    
    override func didMove(to view: SKView) {
        playSound()
        football = getFootballSprite(width: self.size.width)
        goalPost = getGoalPostSprite(width: self.size.width)
        leftPaddle = getPaddle(width: self.size.width, left:true)
        rightPaddle = getPaddle(width: self.size.width, left:false) 
        defender = getDefenderSprite(width: self.size.width, height: self.size.height)
        scoreLabel = getScoreLabel(width: self.size.width, height: self.size.height)
        highScoreLabel = getHSLabel(width: self.size.width, height: self.size.height)
        self.addChild(football)
        self.addChild(goalPost)
        self.addChild(leftPaddle)
        self.addChild(rightPaddle)
        self.addChild(defender)
        self.addChild(scoreLabel)
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        self.physicsBody?.contactTestBitMask = PhysicsStruct.Football
        self.physicsBody?.categoryBitMask = PhysicsStruct.Background
        physicsWorld.contactDelegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if highScoreLabel.parent != nil {
            highScoreLabel.removeFromParent()
        }
        
        if let touch = touches.first as UITouch? {
            startLocation = (touch.location(in: self.scene!.view))
            startTime = touch.timestamp
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as UITouch? {
            var left = 1.0
            let endLocation: CGPoint = touch.location(in: self.scene!.view)
            var endTime = touch.timestamp
            var timeDiff = endTime-startTime!
            var xComponent = (endLocation.x-startLocation!.x)/CGFloat(timeDiff)
            var yComponent = (endLocation.y-startLocation!.y)/CGFloat(timeDiff)
            var theta = atan(yComponent/xComponent)
            if xComponent < 0 {
                left = -1.0
            }
            movementVector = CGVector(dx: CGFloat(left)*magnitudeOfSwipe*cos(theta), dy: abs(magnitudeOfSwipe*sin(theta)))
            football.physicsBody?.velocity = movementVector!
            kicking = true
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if kicking {
            if lastTime != nil {
                var dt = currentTime-lastTime!
                zAxis += zPerDt*dt
                football.physicsBody?.velocity.dy -= CGFloat(accelerationDueToGravity)
                var scale = 1-(zAxis/goalZPos)+0.1
                football.setScale(CGFloat(scale))
            }
        }
        if zAxis >= goalZPos {
            if inContact {
                scored()
            } else {
                gameOver()
            }
            reset()
        }
        lastTime = currentTime
    }
    func didBegin(_ contact: SKPhysicsContact) {
        
        var footballGoal = ((contact.bodyA.categoryBitMask == PhysicsStruct.Football) &&
            (contact.bodyB.categoryBitMask == PhysicsStruct.Goal)) || 
            (contact.bodyB.categoryBitMask == PhysicsStruct.Football) &&
            (contact.bodyA.categoryBitMask == PhysicsStruct.Goal)
        
        var footballDefense = ((contact.bodyA.categoryBitMask == PhysicsStruct.Football) &&
            (contact.bodyB.categoryBitMask == PhysicsStruct.Defense)) || 
            (contact.bodyB.categoryBitMask == PhysicsStruct.Football) &&
            (contact.bodyA.categoryBitMask == PhysicsStruct.Defense)
        
        var footballBorder = ((contact.bodyA.categoryBitMask == PhysicsStruct.Football) &&
            (contact.bodyB.categoryBitMask == PhysicsStruct.Background)) || 
            (contact.bodyB.categoryBitMask == PhysicsStruct.Football) &&
            (contact.bodyA.categoryBitMask == PhysicsStruct.Background)
        
        if footballGoal {
            inContact = true
        }
        
        if footballBorder || footballDefense{
            gameOver()
            reset()
        }
        
    }
    
    func gameOver() {
        kicking = false
        if score > highScore {
            highScore = score
            highScoreLabel.text = String(highScore)
        }
        if highScoreLabel.parent == nil {
            self.addChild(highScoreLabel)
        }
        score = 0
        scoreLabel.text = "0"
    }
    
    func scored() {
        score += 1
        scoreLabel.text = String(score)
    }
    
    func reset() {
        zAxis = 0
        kicking = false
        football.physicsBody?.velocity = CGVector(dx: 0.0, dy: 0.0)
        football.removeFromParent()
        football = getFootballSprite(width: self.size.width)
        self.addChild(football)
    }
    
}
