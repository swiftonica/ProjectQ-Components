//
//  InteractiveListComponent.swift
//  ProjectQ-Components
//
//  Created by Jeytery on 13.02.2023.
//

import Foundation

extension ComponentId {
    public static let interactiveList = ComponentId(id: 3)
}

extension Component {
    public static let interactiveList = Component(
        information: .init(
            name: "Interactive List",
            conflictedComponents: nil,
            componentId: .interactiveList
        ),
        handler: IntervalComponentHandler.self
    )
}

class InteractiveListComponentHandler: InteractiveComponentHandler {
    required init() {}
    
    func getCache() -> Data? {
        return Data()
    }
    
    func isDataCorrect(data: Data) -> Bool {
        return false
    }
    
    func clear() {
            
    }
    
    func data(for data: Data) -> String {
        return ""
    }
}
