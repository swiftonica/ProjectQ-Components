//
//  Task.swift
//  ProjectQ-Components
//
//  Created by Jeytery on 13.02.2023.
//

import Foundation

public struct Task: Codable {
    public init(name: String, baseComponents: BaseComponents) {
        self.name = name
        self.baseComponents = baseComponents
    }
    
    public let name: String
    public var baseComponents: BaseComponents
    
    public var components: Components {
        return baseComponents.compactMap { Component.fromBaseComponent($0) }
    }
    
    public mutating func shouldAppear() -> Bool {
        for componentIndex in 0 ..< components.count {
            let component = components[componentIndex]
            if let handler = component.hanlder as? AppearComponentHandler, let input = component.input {
                let shouldAppear = handler.shouldAppear(data: input)
                if let cachedData = handler.getCache() {
                    component.input = cachedData
                    baseComponents[componentIndex].input = cachedData
                }
                return shouldAppear
            }
        }
        return false
    }
}

public typealias Tasks = [Task]

