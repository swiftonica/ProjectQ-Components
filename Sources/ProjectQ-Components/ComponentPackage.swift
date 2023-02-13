//
//  ComponentPackage.swift
//  ProjectQ-Components
//
//  Created by Jeytery on 13.02.2023.
//

import Foundation

struct ComponentPackage: Codable {
    let name: String
    let baseComponents: BaseComponents
    
    var components: Components {
        return baseComponents.compactMap { Component.fromBaseComponent($0) }
    }
}

