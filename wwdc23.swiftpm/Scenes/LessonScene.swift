//
//  File.swift
//  
//
//  Created by Lucas Flores on 11/04/23.
//

import Foundation
import SpriteKit
import SwiftUI

class LessonScene: SKScene {
    weak var sceneManager: SceneManager?
    var lessonBackground = SKSpriteNode(imageNamed: "lesson")
    var button = SKLabelNode(text: "NEXT")
    var robot = SKSpriteNode(imageNamed: "robot_turned_right")
    var robotText = SKSpriteNode(imageNamed: "lesson_text1")
    var isNextButtonAvailable = false
    var isTextClickable = false
    var currentRobotText = 1
    
    override func didMove(to view: SKView) {
        
        setupLessonScene()
    }
    
    func setupLessonScene() {
        
        setupLessonBackGround()
        setupButton()
        setupRobot()
        setupRobotText()
        
    }

    
    func setupLessonBackGround() {
        let middle = CGPoint(x: 417, y: 597)
        self.lessonBackground.position = middle
        self.lessonBackground.size = CGSize(width: 820, height: 1180)
        self.addChild(self.lessonBackground)
    }
    
    func setupButton() {
        button.fontColor = .black
        button.position = CGPoint(x: 760, y: 50)
//        self.addChild(button)
    }
    
    func setupRobot() {
        self.robot.size = CGSize(width: 200, height: 320)
        self.robot.position = CGPoint(x: -200, y: 700)
        let mvAction = SKAction.moveTo(x: 10, duration: 2)
        self.addChild(robot)
        robot.run(mvAction)
    }
    
    func setupRobotText() {
        robotText.position = CGPoint(x: 250, y: 760)
        robotText.size = CGSize(width: 300, height: 150)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.addChild(self.robotText)
            self.isTextClickable = true
        }
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        if isTextClickable && self.robotText.contains(location) {
            currentRobotText += 1
            if (currentRobotText > 4) {
                self.addChild(button)
                isNextButtonAvailable = true
                robot.removeFromParent()
                robotText.removeFromParent()
            }
            else {robotText.texture = SKTexture(imageNamed: "lesson_text\(currentRobotText)")}
        }
        if isNextButtonAvailable && self.button.contains(location) {
            sceneManager?.goToScene(.simulationScene)
        }
    }
    
}
