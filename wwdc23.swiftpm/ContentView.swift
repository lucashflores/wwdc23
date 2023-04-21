import SwiftUI
import SpriteKit



struct ContentView: View {
    @StateObject var sceneManager = SceneManager()
    @State private var temperature = 0.0
    
    init() {
    }


    var body: some View {
        switch sceneManager.selectedScene {
        case Scenes.titleScreen:
            SpriteView(scene: sceneManager.getTitleScreen())
        case Scenes.introScene:
            SpriteView(scene: sceneManager.getIntroScene()).ignoresSafeArea()
        case Scenes.historyScene:
            SpriteView(scene: sceneManager.getHistoryScene())
        case Scenes.lessonScene:
            SpriteView(scene: sceneManager.getLessonScene()).ignoresSafeArea()
            
        case Scenes.simulationScene:
            ZStack {
                SpriteView(scene: sceneManager.simulationScene).ignoresSafeArea()
                if #available(iOS 16.0, *) {
                    Gauge(value: temperature, in: 0...60) {}
                    .tint(Gradient(colors: [.blue, .yellow, .orange, . red]))
                    .rotationEffect(Angle(degrees: -90.0))
                    .frame(width: 230, height: 30)
                    .position(x: 121, y: 597)
                    Slider(value: $temperature, in: 0...60)
                        .rotationEffect(Angle(degrees: -90.0))
                        .opacity(0.015)
                        .frame(width: 230, height: 30)
                        .position(x: 121, y: 597)
                    
                } else {
                    Slider(value: $temperature, in: 0...60)
                        .rotationEffect(Angle(degrees: -90.0))
                        .opacity(0.015)
                        .frame(width: 230, height: 30)
                        .position(x: 121, y: 597)
                }
            }
            .onChange(of: temperature) { newValue in
                sceneManager.simulationScene.updateTemp(temp: newValue)
            
            }
            .frame(width: 834, height: 1194)
        }
    }
    
    
}
