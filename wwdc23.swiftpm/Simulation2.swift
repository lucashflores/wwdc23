//
//  Simulation2.swift
//  wwdc23
//
//  Created by Lucas Flores on 18/04/23.
//

import Foundation
//
//  File.swift
//
//
//  Created by Lucas Flores on 11/04/23.
//

import Foundation
import SpriteKit

class SimulationTwo {
    private var timer: Timer
    public var movementidx: Int!
    public var nodes: [SKSpriteNode] = []
    public var bounds: [SKNode] = []
    public var nodeNumber: Int
    public var temperature: Double = 0
    var count = 0
    var middle: CGPoint!
    var size: CGSize!
    
    init(size: CGSize, middle: CGPoint, nodeNum: Int, temp: Double) {
        self.nodeNumber = nodeNum
        self.timer = Timer()
        self.middle = middle
        self.size = size
        self.temperature = temp
        if (temp > 60)
        {
            self.temperature = 60
        }
        if (temp < 0)
        {
            self.temperature = 0
        }
        setupBounds()
        setupNodes()
        generatePositions()
        self.timer =  Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(simulate), userInfo: nil, repeats: true)
    }
    
    func setupBounds() {
        let width = self.size.width
        let height = self.size.height
        let midX = self.middle.x
        let midY = self.middle.y
        let bottom = SKNode()
        
        bottom.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: 1))
        bottom.position = CGPoint(x: midX, y: midY - height/2)
        configureBound(bound: bottom)
        
        let top = SKNode()
        
        top.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: 1))
        top.position = CGPoint(x: midX, y: midY + height/2)
        configureBound(bound: top)
        
        let left = SKNode()
        
        left.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: height))
        left.position = CGPoint(x: midX - width/2, y: midY)
        configureBound(bound: left)
        
        let right = SKNode()
        
        right.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: height))
        right.position = CGPoint(x: midX + width/2, y: midY)
        configureBound(bound: right)
    }
    
    func configureBound(bound: SKNode) {
        bound.physicsBody?.affectedByGravity = false
        bound.physicsBody?.isDynamic = false
        bound.physicsBody?.collisionBitMask = 0b001
        bound.physicsBody?.categoryBitMask = 0b010
        bounds.append(bound)
    }
    
    func setupNodes() {
        for i in 0...(nodeNumber-1) {
            nodes.append(SKSpriteNode(imageNamed: "atom"))
            nodes[i].size = CGSize(width: 20, height: 20)
            nodes[i].physicsBody = SKPhysicsBody(circleOfRadius: 9.8)
            if (self.temperature >= 35) {
                nodes[i].physicsBody?.affectedByGravity = false
            }
            else {
                nodes[i].physicsBody?.affectedByGravity = true
            }
            nodes[i].physicsBody?.usesPreciseCollisionDetection = true
            nodes[i].physicsBody?.mass = 0.00000001
            nodes[i].physicsBody?.restitution = 0.3
            nodes[i].physicsBody?.friction = CGFloat(0.6)
            nodes[i].physicsBody?.isDynamic = true
            nodes[i].physicsBody?.categoryBitMask = 0b001
            nodes[i].physicsBody?.collisionBitMask = 0b001 | 0b010
            
        }
    }
    
    @objc func simulate() {
        count += 1
        for node in nodes {
            var mvIdx = self.temperature / 200000
            var randomDx = Double.random(in: -mvIdx...mvIdx)
            var randomDy = Double.random(in: -mvIdx/2...mvIdx/2)
            if (temperature > 0 && temperature < 20) {
                node.physicsBody?.affectedByGravity = true
                let mvActionLeft = SKAction.moveTo(x: node.position.x - 1, duration: 0.05)
                let mvActionRight = SKAction.moveTo(x: node.position.x + 1, duration: 0.05)
                if (count % 2 == 0) {
                    node.run(mvActionLeft)
                }
                else {
                    node.run(mvActionRight)
                }
            }
            else if (temperature >= 20 && temperature < 35) {
                node.physicsBody?.affectedByGravity = true
                node.physicsBody?.applyForce(CGVector(dx: randomDx, dy: randomDy))
            }
            if (temperature >= 35)
            {
                mvIdx = self.temperature / 800000
                randomDx = Double.random(in: -mvIdx...mvIdx)
                randomDy = Double.random(in: -mvIdx...mvIdx)
                node.physicsBody?.affectedByGravity = false
                randomDx = Double.random(in: -mvIdx...mvIdx)
                randomDy = Double.random(in: -mvIdx...mvIdx)
                node.physicsBody?.applyForce(CGVector(dx: randomDx, dy: randomDy))
            }
        }
    }
    
    
    
    func generatePositions() {
        switch self.temperature {
        case _ where self.temperature < 20:
            self.generateSolidPositions()
        case _ where self.temperature >= 20 && self.temperature < 35:
            self.generateLiquidPositions()
        case _ where self.temperature >= 35 && self.temperature <= 60:
            self.generateGasPositions()
        default:
            self.generateSolidPositions()
        }
    }
    
    func generateGasPositions() {
        for node in self.nodes {
            let minX: Float  = Float(self.middle.x - self.size.width/2)
            let maxX: Float  = Float(self.middle.x + self.size.width/2)
            let minY: Float  = Float(self.middle.y - self.size.height/2)
            let maxY: Float  = Float(self.middle.y + self.size.height/2)
            let randomX = Float.random(in: minX...maxX)
            let randomY = Float.random(in: minY...maxY)
            node.position = CGPoint(x: CGFloat(randomX), y: CGFloat(randomY))
        }
    }
    
    func generateSolidPositions() {
        let lineSize = (nodeNumber / 8) * 20
        let startX = Int(self.middle.x) - lineSize/2 + 10
        let startY = self.middle.y - self.size.height/2 + 20
        var idx: Int = 0
        for node in self.nodes {
            let remainder = idx % 8
            let posX = startX + Int(CGFloat(remainder*20))
            let posY = startY + CGFloat((idx / 8)*20)
            node.position = CGPoint(x: CGFloat(posX), y: CGFloat(posY))
            idx += 1
        }
    }
    
    func generateLiquidPositions() {
        for node in self.nodes {
            let minX: Float  = Float(self.middle.x - self.size.width/2)
            let maxX: Float  = Float(self.middle.x + self.size.width/2)
            let minY: Float  = Float(self.middle.y - self.size.height/2)
            let midY: Float  = Float(self.middle.y)
            let randomX = Float.random(in: minX...maxX)
            let randomY = Float.random(in: minY...midY)
            node.position = CGPoint(x: CGFloat(randomX), y: CGFloat(randomY))
            
        }
    }
}
