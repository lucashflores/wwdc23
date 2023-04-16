//
//  File.swift
//  
//
//  Created by Lucas Flores on 14/04/23.
//

import Foundation
import SwiftUI
import SpriteKit

class SceneManager: ObservableObject {
    @Published var selectedScene = Scenes.titleScreen
    
    init() {}

    func goToScene(_ scene: Scenes) {
        selectedScene = scene
    }

    func getTitleScreen() -> SKScene {
       let scene = TitleScreen(size: CGSize(width: 834, height: 1194))
       scene.scaleMode = .aspectFill
       scene.sceneManager = self
       return scene
    }

    func getIntroScene() -> SKScene {
       let scene = IntroScene(size: CGSize(width: 834, height: 1194))
       scene.scaleMode = .aspectFill
       scene.sceneManager = self
       return scene
    }
    
    func getHistoryScene() -> SKScene {
        let scene = HistoryScene(size: CGSize(width: 834, height: 1194))
        scene.scaleMode = .aspectFill
        scene.sceneManager = self
        return scene
    }
}
