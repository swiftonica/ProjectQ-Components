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
    public static var logicalList: Component {
        return Component(
            information: .init(
                name: "Logical List",
                conflictedComponents: nil,
                componentId: .logicalList
            ),
            handler: LogicalListComponentHandler.self
        )
    }
}

class LogicalListComponentHandler: DataComponentHandler {
    required init() {}
    
    func getCache() -> Data? {
        return Data()
    }
    
    func data(for data: Data) -> String {
        return ""
    }
}
