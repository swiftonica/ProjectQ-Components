//
//  DescriptionComponent.swift
//  ProjectQ-Components
//
//  Created by Jeytery on 12.03.2023.
//

import Foundation

extension ComponentId {
    public static var description: ComponentId {
        return .init(id: 4)
    }
}

extension Component {
    public static var description: Component {
        return Component(
            information: .init(
                name: "Description",
                conflictedComponents: nil,
                componentId: .description
            ),
            handler: DescriptionComponentHandler.self
        )
    }
}

class DescriptionComponentHandler: DataComponentHandler {
    struct Input: Codable {
        let description: String
    }
    
    required init() {}
    
    func data(for data: Data) -> String {
        guard let input = try? JSONDecoder().decode(DescriptionComponentHandler.Input.self, from: data) else {
            return "Error with decoding"
        }
        return input.description
    }
    
    func getCache() -> Data? {
        return nil
    }
}
