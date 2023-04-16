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
    var startButton : SKLabelNode!
    var gameTitle : UILabel!
    
    override func didMove(to view: SKView) {
        setupMainScreen()
        
    }
    
    func setupMainScreen() {
        self.backgroundColor = UIColor(named: "cor_fundo_menu")!
        setUpTitleText()
        setupStartButton()
        setUpTitleText()
    }
    
    func setUpTitleText(){
        gameTitle = UILabel(frame: CGRect(x: 0, y: 0, width: view!.frame.width, height: 300))
        gameTitle.textColor = UIColor.black
        gameTitle.font = UIFont(name: "Futura", size: 50)
        gameTitle.textAlignment = NSTextAlignment.center
        gameTitle.text = "States of the Matter"
        self.view?.addSubview(gameTitle)
    }
    
    func setupStartButton() {
        startButton = SKLabelNode(text: "START")
        startButton.position = CGPoint(x: view!.frame.width / 2, y: 100)
        startButton.fontColor = .black
//        startButton.setTitleColor(.orange, for: UIControl.State.normal)
//        startButton.addTarget(self, action: #selector(GameScreen.buttonClicked), for: .touchUpInside)
        self.addChild(startButton)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        if self.startButton != nil && self.startButton.contains(location) {
            sceneManager?.goToScene(.introScene)
        }
    }

}
