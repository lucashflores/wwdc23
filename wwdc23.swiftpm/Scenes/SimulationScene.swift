//
//  File.swift
//  
//
//  Created by Lucas Flores on 11/04/23.
//

import Foundation
import SpriteKit
import SwiftUI

class SimulationScene: SKScene {
    weak var sceneManager: SceneManager?
    var thermometer = SKSpriteNode(imageNamed: "thermometer")
    var simulation = SimulationTwo(size: CGSize(width: 390, height: 390), middle: CGPoint(x: 412, y: 601), nodeNum: 40, temp:0)
    var background = SKSpriteNode(imageNamed: "sim_background")
    var glass = SKSpriteNode(imageNamed: "glass")
    var robotText = SKSpriteNode(imageNamed: "simulation_text1")
    var currentRobotText = 1

    override func didMove(to view: SKView) {
        backgroundColor = .black
        setupSimulation()
        setupBackground()
        setupThermometerImage()
        setupGlass()
        setupRobotText()
        
    }

    func setupThermometerImage() {
        thermometer.size = CGSize(width: 80, height: 340)
        thermometer.position = CGPoint(x: 120, y: 597)
        self.addChild(thermometer)
    }

    func setupSimulation() {
        for node in self.simulation.nodes {
            self.addChild(node)
        }
        for bound in self.simulation.bounds {
            self.addChild(bound)
        }
    }
    
    func setupBackground() {
        self.background.position = CGPoint(x: 417, y: 597)
        self.background.size = CGSize(width: 834, height: 1194)
        self.addChild(background)
    }
    
    func setupGlass() {
        self.glass.position = CGPoint(x: 412, y: 601)
        self.glass.size = CGSize(width: 405, height: 405)
        self.addChild(glass)
    }
    
    func setupRobotText() {
        self.robotText.position = CGPoint(x: 417, y: 1050)
        self.robotText.size = CGSize(width: 750, height: 110)
        self.addChild(self.robotText)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        if self.robotText.contains(location) {
            currentRobotText += 1
            if (currentRobotText > 6) {
                robotText.removeFromParent()
            }
            else {robotText.texture = SKTexture(imageNamed: "simulation_text\(currentRobotText)")}
        }
    }
    
    public func updateTemp(temp: Double) {
        self.simulation.temperature = temp
    }
}
