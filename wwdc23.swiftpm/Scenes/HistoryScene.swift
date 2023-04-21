//
//  File.swift
//
//
//  Created by Lucas Flores on 10/04/23.
//

import Foundation
import SpriteKit
import SwiftUI

class HistoryScene: SKScene {
    weak var sceneManager: SceneManager?
    var background = SKSpriteNode(imageNamed: "aged_paper")
    var robotText =  SKSpriteNode(imageNamed: "history_text1")
    var waterAncientGreece = SKSpriteNode(imageNamed: "water_ancient_greece")
    var agora = SKSpriteNode(imageNamed: "agora")
    var thales = SKSpriteNode(imageNamed: "thales")
    var currentRobotText = 1
    
    override func didMove(to view: SKView) {
        setupHistoryScene()
    }
    
    func setupHistoryScene() {
        setupBackground()
        setupRobotText()
        setupWaterAncientGreeceImage()
        setupAgoraImage()
        setupThalesImage()
    }
    
    func setupBackground() {
        self.background.position = CGPoint(x: 417, y: 597)
        self.background.size.width = self.size.width
        self.background.size.height = self.size.height
        self.background.anchorPoint = CGPoint(x: 0.5,y: 0.5)

        self.addChild(background)
    }
    
    func setupRobotText() {
        self.robotText.position = CGPoint(x: 417, y: 1050)
        self.robotText.size = CGSize(width: 750, height: 110)
        self.addChild(self.robotText)
    }
    
    func setupWaterAncientGreeceImage() {
        self.waterAncientGreece.position = CGPoint(x: 417, y: 340)
        self.waterAncientGreece.size = CGSize(width: 200, height: 200)
    }
    
    func setupAgoraImage() {
        self.agora.position = CGPoint(x: 220, y: 600)
        self.agora.size = CGSize(width: 200, height: 200)
    }
    
    func setupThalesImage() {
        self.thales.position = CGPoint(x: 600, y: 560)
        self.thales.size = CGSize(width: 200, height: 200)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        if (robotText.contains(location)) {
            currentRobotText += 1
            if (currentRobotText < 6) {
                if (currentRobotText == 2) {
                    self.addChild(self.agora)
                }
                if (currentRobotText == 4) {
                    self.addChild(self.waterAncientGreece)
                }
                if (currentRobotText == 5) {
                    self.addChild(self.thales)
                }
                robotText.texture = SKTexture(imageNamed: "history_text\(currentRobotText)")
            }
            else {
                sceneManager?.goToScene(.lessonScene)
            }
        }
    }
}
 
