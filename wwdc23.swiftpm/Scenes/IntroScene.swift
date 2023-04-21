//
//  File.swift
//  
//
//  Created by Lucas Flores on 11/04/23.
//

import Foundation
import SpriteKit

class IntroScene: SKScene {
    weak var sceneManager: SceneManager!
    var simulation = SimulationTwo(size: CGSize(width: 834, height: 1194), middle: CGPoint(x: 417, y: 597), nodeNum: 100, temp: 50.0)
    var robot = SKSpriteNode(imageNamed:"robot")
    var robotText = SKSpriteNode(imageNamed: "intro_text1")
    var currentRobotText = 1
    var isTextClickable = false
    
    override func didMove(to view: SKView) {
        setupIntroductionScreen()
    }
    
    func setupIntroductionScreen() {
        backgroundColor = .gray
        setupGasIntroSimulation()
        setupRobot()
        setupRobotText()
     }

    
    func setupGasIntroSimulation() {
        for node in self.simulation.nodes {
            self.addChild(node)
        }
        for bound in self.simulation.bounds {
            self.addChild(bound)
        }
    }
    
    func setupRobot() {
        self.robot.size = CGSize(width: 200, height: 320)
        self.robot.position = CGPoint(x: 150, y: -200)
        let mvAction = SKAction.moveTo(y: 80, duration: 3)
        self.addChild(robot)
        robot.run(mvAction)
    }
    
    func setupRobotText() {
        robotText.position = CGPoint(x: 450, y: 170)
        robotText.size = CGSize(width: 400, height: 200)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            self.addChild(self.robotText)
            self.isTextClickable = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        if isTextClickable && self.robotText.contains(location) {
            currentRobotText += 1
            if (currentRobotText > 5) {
                sceneManager.goToScene(.historyScene)
            }
            else {robotText.texture = SKTexture(imageNamed: "intro_text\(currentRobotText)")}
        }
    }
    

}
