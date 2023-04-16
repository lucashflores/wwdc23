import SwiftUI
import SpriteKit


struct ContentView: View {
    @StateObject var sceneManager = SceneManager()
    
    init() {
    }


    var body: some View {
        switch sceneManager.selectedScene {
        case Scenes.titleScreen:
            SpriteView(scene: sceneManager.getTitleScreen())
        case Scenes.introScene:
            SpriteView(scene: sceneManager.getIntroScene())
        case Scenes.historyScene:
            SpriteView(scene: sceneManager.getHistoryScene())
        default:
            SpriteView(scene: sceneManager.getTitleScreen())
        
        }
    }
    
    
}
