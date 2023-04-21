//
//  File.swift
//  
//
//  Created by Lucas Flores on 14/04/23.
//

import Foundation
import SwiftUI
import SpriteKit

class TitleScreen: SKScene {
    weak var sceneManager: SceneManager!
    var startButton = SKSpriteNode(imageNamed: "play_btn")
    var logo = SKSpriteNode(imageNamed: "logo")
    var robotLab = SKSpriteNode(imageNamed: "robot_lab")
    
    override func didMove(to view: SKView) {
        setupMainScreen()
        
    }
    
    func setupMainScreen() {
        self.backgroundColor = .white
        setupLogo()
        setupStartButton()
        setupRobotLab()
    }
    
    func setupLogo(){
        logo.position = CGPoint(x: 417, y: 1000)
        logo.size = CGSize(width: 280, height: 115)
        self.addChild(logo)
    }
    
    func setupStartButton() {
        startButton.position = CGPoint(x: 417, y: 100)
        startButton.size = CGSize(width: 200, height: 115)
        self.addChild(startButton)
    }
    
    func setupRobotLab() {
        robotLab.position = CGPoint(x: 417, y: 500)
        robotLab.size = CGSize(width: 600, height: 400)
        self.addChild(robotLab)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        if self.startButton.contains(location) {
            sceneManager?.goToScene(.introScene)
        }
    }

}
