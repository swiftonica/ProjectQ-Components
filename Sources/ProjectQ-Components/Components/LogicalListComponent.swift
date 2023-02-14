//
//  LogicalListComponent.swift
//  ProjectQ-Components
//
//  Created by Jeytery on 13.02.2023.
//

import Foundation

extension ComponentId {
    public static let logicalList = ComponentId(id: 2)
}

extension Component {
    public static let logicalList = Component(
        information: .init(
            name: "Logical List",
            conflictedComponents: nil,
            componentId: .logicalList
        ),
        handler: IntervalComponentHandler.self
    )
}

class LogicalListComponentHandler: DataComponentHandler {
    func getCache() -> Data? {
        return Data()
    }
    
    func data(for data: Data) -> String {
        return ""
    }
}
