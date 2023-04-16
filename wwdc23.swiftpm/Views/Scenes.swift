//
//  Scenes.swift
//  wwdc23
//
//  Created by Lucas Flores on 14/04/23.
//

import Foundation
import SwiftUI

enum Scenes: String, Identifiable, CaseIterable {
    case titleScreen, introScene, historyScene, lessonScreen, simulationScreen

    var id: String { self.rawValue }
}
