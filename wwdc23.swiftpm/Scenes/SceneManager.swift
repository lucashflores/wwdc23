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
    
    lazy var simulationScene = getSimulationScene()
    init() {
    }

    func goToScene(_ scene: Scenes) {
        selectedScene = scene
    }

    func getTitleScreen() -> SKScene {
       let scene = TitleScreen(size: CGSize(width: 834, height: 1194))
       scene.scaleMode = .aspectFit
       scene.sceneManager = self
       return scene
    }

    func getIntroScene() -> SKScene {
       let scene = IntroScene(size: CGSize(width: 834, height: 1194))
       scene.scaleMode = .aspectFit
       scene.sceneManager = self
       return scene
    }
    
    func getHistoryScene() -> SKScene {
        let scene = HistoryScene(size: CGSize(width: 834, height: 1194))
        scene.scaleMode = .aspectFit
        scene.sceneManager = self
        return scene
    }
    
    func getLessonScene() -> SKScene {
        let scene = LessonScene(size: CGSize(width: 834, height: 1194))
        scene.scaleMode = .aspectFit
        scene.sceneManager = self
        return scene
    }
    
    func getSimulationScene() -> SimulationScene {
        let scene = SimulationScene(size: CGSize(width: 834, height: 1194))
        scene.scaleMode = .aspectFit
        scene.sceneManager = self
        return scene
    }
}
