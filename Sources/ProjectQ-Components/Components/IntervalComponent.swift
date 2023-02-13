//
//  IntervalComponent.swift
//  ProjectQ-Components
//
//  Created by Jeytery on 13.02.2023.
//

import Foundation

extension ComponentId {
    public static let interval = ComponentId(id: 1)
}

extension Component {
    public static let interval = Component(
        information: .init(
            name: "Interval",
            conflictedComponents: nil,
            componentId: .interval
        ),
        handler: IntervalComponentHandler.self
    )
}

struct IntervalComponentHandlerInput {
    
}

class IntervalComponentHandler: AppearComponentHandler {
    func shouldAppear(data: Data) -> Bool {
        return false
    }
}


