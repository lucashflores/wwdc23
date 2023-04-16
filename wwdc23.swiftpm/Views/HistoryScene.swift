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
    
    override func didMove(to view: SKView) {
        setupHistoryScene()
    }
    
    func setupHistoryScene() {
        setupBackground()
        setupIntroductionText()
        setupTempleImage()
        setupAgoraImage()
        setupThalesImage()
    }
    
    func setupBackground() {
        let background = SKSpriteNode(imageNamed: "aged_paper")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.size.width = self.size.width
        background.size.height = self.size.height
        background.anchorPoint = CGPoint(x: 0.5,y: 0.5)

        self.addChild(background)
    }
    
    func setupLine() {
        let line = SKSpriteNode(imageNamed: "div_line")
        line.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        line.size = CGSize(width: 2, height: 350)
        self.addChild(line)
    }
    
    func setupIntroductionText() {
        let text =  SKLabelNode(text: "Welcome, I'm Floriam the robot and I'll be your guide in our little chemistry adventure, but first, a history lesson is in order")
        text.fontName = "Futura"
        text.fontSize = 10
        text.numberOfLines = 0
        text.lineBreakMode = NSLineBreakMode.byWordWrapping
        text.fontColor = .black
        text.preferredMaxLayoutWidth = 250
        text.position = CGPoint(x: 150, y: 300)
        self.addChild(text)
    }
    
    func setupTempleImage() {
        let greekTemple = SKSpriteNode(imageNamed: "greek_temple")
        greekTemple.position = CGPoint(x: 80, y: 100)
        greekTemple.size = CGSize(width: 80, height: 80)
        self.addChild(greekTemple)
    }
    
    func setupAgoraImage() {
        let agora = SKSpriteNode(imageNamed: "agora")
        agora.position = CGPoint(x: 220, y: 100)
        agora.size = CGSize(width: 80, height: 80)
        self.addChild(agora)
    }
    
    func setupThalesImage() {
        let thales = SKSpriteNode(imageNamed: "thales")
        thales.position = CGPoint(x: 180, y: 210)
        thales.size = CGSize(width: 80, height: 80)
        self.addChild(thales)
    }
}
 
