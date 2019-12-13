//
//  GameScene.swift
//  Ping-Pong
//
//  Created by Prashuk Ajmera on 5/21/19.
//  Copyright © 2019 Prashuk Ajmera. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation
import CoreMotion

class GameScene: SKScene {
    
    var motion = CMMotionManager()
    
    var ball = SKSpriteNode()
    var main = SKSpriteNode()
    var enemy = SKSpriteNode()
    
    var topLbl = SKLabelNode()
    var bottomLbl = SKLabelNode()
    var whoWon = SKLabelNode()
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        topLbl = self.childNode(withName: "topLbl") as! SKLabelNode
        bottomLbl = self.childNode(withName: "bottomLbl") as! SKLabelNode
        whoWon = self.childNode(withName: "whoWon") as! SKLabelNode
        
//        ball.position.y = (self.frame.height / 2)
        main.position.y = (-self.frame.height / 2) + 100
        enemy.position.y = (self.frame.height / 2) - 100
        
        bottomLbl.position.y = (-self.frame.height / 2) + 40
        topLbl.position.y = (self.frame.height / 2) - 40
        
        bottomLbl.position.x = (-self.frame.width / 2) + 40
        topLbl.position.x = (self.frame.width / 2) - 40
                
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        
        whoWon.isHidden = true
        
//        let backTexture: SKTexture! = SKTexture(imageNamed: "clear.png")
//        let backTextureSelected: SKTexture! = SKTexture(imageNamed: "clear.png")
//        let backBtn = FTButtonNode(normalTexture: backTexture, selectedTexture: backTextureSelected, disabledTexture: backTexture)
//        backBtn.setButtonAction(target: self, triggerEvent: .TouchUp, action: "backBtnTap:")
//        backBtn.size = CGSize(width: 30, height: 30)
//        backBtn.position = CGPoint(x: (-self.frame.width / 2) + 20, y: (self.frame.height / 2) - 20)
//        backBtn.zPosition = 1
//        backBtn.name = "backBtn"
//        self.addChild(backBtn)
        
        startGame()
    }
    
    func getIMUData() {
        if motion.isDeviceMotionAvailable {
            self.motion.deviceMotionUpdateInterval = 1.0 / 60.0
            self.motion.showsDeviceMovementDisplay = true
            self.motion.startDeviceMotionUpdates(using: .xArbitraryZVertical, to: .main, withHandler: { (data, error) in
             if let validData = data {
                let roll = validData.attitude.roll
                let pitch = validData.attitude.pitch
                let yaw = validData.attitude.yaw
                print(roll, pitch, yaw)
             }
          })
       }
    }

    func startGame() {
        
        getIMUData()

        score = [0,0]
        topLbl.text = "\(score[0])"
        bottomLbl.text = "\(score[1])"
        
        switch currentGameType {
            case 11:
                ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
                break
            case 12:
                ball.physicsBody?.applyImpulse(CGVector(dx: 15, dy: 15))
                break
            case 13:
                ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
                break
            case 20:
                ball.physicsBody?.applyImpulse(CGVector(dx: 15, dy: 15))
                break
            case 21:
                ball.physicsBody?.applyImpulse(CGVector(dx: 15, dy: 15))
                break
            default:
                break
        }
    }
    
    func addScore(playerWhoWon: SKSpriteNode) {
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)

        if playerWhoWon == main {
            score[0] += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
               switch currentGameType {
                   case 11:
                        self.ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
                        break
                   case 12:
                        self.ball.physicsBody?.applyImpulse(CGVector(dx: 15, dy: 15))
                        break
                   case 13:
                        self.ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
                        break
                   case 20:
                        self.ball.physicsBody?.applyImpulse(CGVector(dx: 15, dy: 15))
                        break
                   case 21:
                        self.ball.physicsBody?.applyImpulse(CGVector(dx: 15, dy: 15))
                        break
                   default:
                        break
                }
            }
        } else if playerWhoWon == enemy {
            score[1] += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
               switch currentGameType {
                   case 11:
                        self.ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: -10))
                        break
                   case 12:
                        self.ball.physicsBody?.applyImpulse(CGVector(dx: -15, dy: -15))
                        break
                   case 13:
                        self.ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
                        break
                   case 20:
                        self.ball.physicsBody?.applyImpulse(CGVector(dx: -15, dy: -15))
                        break
                   case 21:
                        self.ball.physicsBody?.applyImpulse(CGVector(dx: -15, dy: -15))
                        break
                   default:
                        break
                }
            }
        }
        
        topLbl.text = "\(score[0])"
        bottomLbl.text = "\(score[1])"
        
        if score[0] == 5 || score[1] == 5 {
            ball.isHidden = true
            whoWon.isHidden = false
            ball.position = CGPoint(x: 0, y: 0)
            ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 0))
//            currentGameType = 0
            scene?.view?.isPaused = true
            if currentGameType == 20 || currentGameType == 21 {
                if score[0] == 5 {
                    whoWon.text = "Player 1 Won"
                } else {
                    whoWon.text = "Player 2 Won"
                }
            } else {
                if score[0] == 5 {
                    whoWon.text = "You Won"
                } else {
                    whoWon.text = "Computer Won"
                }
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == 20 || currentGameType == 21 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0))
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0))
                }
            } else {
                main.run(SKAction.moveTo(x: location.x, duration: 0))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == 20 || currentGameType == 21 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0))
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0))
                }
            } else {
                main.run(SKAction.moveTo(x: location.x, duration: 0))
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        switch currentGameType {
            case 11:
                enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.3))
                break
            case 12:
                enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
                break
            case 13:
                enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.7))
                break
            case 20:
                break
            case 21:
                break
            default:
                break
        }
        
        if ball.position.y < 0 && ball.position.y < main.position.y - 30 {
            addScore(playerWhoWon: enemy)
        } else if ball.position.y > 0 && ball.position.y > enemy.position.y + 30 {
            addScore(playerWhoWon: main)
        }
    }
    
    func backBtnTap() {
        print("backbtn tapped")
    }
}
