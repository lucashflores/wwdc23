//
//  File.swift
//  
//
//  Created by Lucas Flores on 11/04/23.
//

import Foundation
import SpriteKit

class Simulation {
    private var timer = Timer()
    public var movementidx: Int!
    public var nodes: [SKSpriteNode] = []
    public var bounds: [SKNode] = []
    public var nodeNumber: Int
    public var temperature: Int!
    var middle: CGPoint!
    var size: CGSize!
    
    init(middle: CGPoint, size: CGSize, nodeNum: Int, temp: Int) {
        self.nodeNumber = nodeNum
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
        self.generatePositions()
        self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(simulate), userInfo: nil, repeats: true)
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
            nodes[i].physicsBody = SKPhysicsBody(circleOfRadius: 10)
            if (self.temperature >= 35) {
                nodes[i].physicsBody?.affectedByGravity = false
            }
            else {
                nodes[i].physicsBody?.affectedByGravity = true
            }
            nodes[i].physicsBody?.usesPreciseCollisionDetection = true
            nodes[i].physicsBody?.mass = 0.005
            nodes[i].physicsBody?.restitution = 0.3
            nodes[i].physicsBody?.isDynamic = true
            nodes[i].physicsBody?.categoryBitMask = 0b001
            nodes[i].physicsBody?.collisionBitMask = 0b001 | 0b010
        }
    }
    
    @objc func simulate() {
        let mvIdx = self.temperature / 10
        for node in nodes {
            if (self.temperature >= 35) {
                node.physicsBody?.affectedByGravity = false
            }
            else {
                node.physicsBody?.affectedByGravity = true
            }
            let randomDx = Int.random(in: -mvIdx...mvIdx)
            let randomDy = Int.random(in: -mvIdx...mvIdx)
            node.physicsBody?.applyForce(CGVector(dx: randomDx, dy: randomDy))
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
//        let startX = self.groundSprite.frame.minX + self.groundSprite.frame.maxX / 2 - 25
//        var idx: Int = 0
//        for node in self.nodes {
//            let remainder = idx % 5
//            let posX = (remainder > 0) ? startX : (startX + CGFloat(remainder*10))
//            let posY = CGFloat((idx / 5)*10 + 5)
//            node.position = CGPoint(x: posX, y: posY)
//            idx += 1
//        }
    }
    
    func generateLiquidPositions() {
//        for node in self.nodes {
//            let minX: Float  = Float(self.groundSprite.frame.minX)
//            let maxX: Float  = Float(self.groundSprite.frame.maxX)
//            let minY: Float  = Float(self.groundSprite.frame.minY)
//            let randomX = Float.random(in: minX...maxX)
//            let randomY = Float.random(in: 0...(minY / 3))
//            node.position = CGPoint(x: CGFloat(randomX), y: CGFloat(randomY))
//        }
    }
}
