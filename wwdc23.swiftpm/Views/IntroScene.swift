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
    var simulation = Simulation(middle: CGPoint(x: 417, y: 597), size: CGSize(width: 834, height: 1160), nodeNum: 100, temp: 50)
    var robot = SKSpriteNode(imageNamed:"robot")
    var robotText = SKSpriteNode(imageNamed: "intro_text1")
    var currentRobotText = 1
    
    override func didMove(to view: SKView) {
        setupIntroductionScreen()
    }
    
    func setupIntroductionScreen() {
        backgroundColor = .black
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
        let mvAction = SKAction.moveTo(y: 70, duration: 3)
        self.addChild(robot)
        robot.run(mvAction)
    }
    
    func setupRobotText() {
        robotText.position = CGPoint(x: 400, y: 150)
        robotText.size = CGSize(width: 300, height: 200)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            self.addChild(self.robotText)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        if self.robotText.contains(location) {
            currentRobotText += 1
            if (currentRobotText > 3) {
                sceneManager.goToScene(.historyScene)
            }
            else {robotText.texture = SKTexture(imageNamed: "intro_text\(currentRobotText)")}
        }
    }
    

}
