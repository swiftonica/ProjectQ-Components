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
    
    public static func description(input: DescriptionComponentHandler.Input) -> Component {
        guard let input = try? JSONEncoder().encode(input) else {
            return self.description
        }
        return self.description.inputed(input)
    }
}

public class DescriptionComponentHandler: DataComponentHandler {
    public struct Input: Codable {
        public init(description: String) {
            self.description = description
        }
        
        public let description: String
    }
    
    public required init() {}
    
    public func data(for data: Data) -> String {
        guard let input = try? JSONDecoder().decode(DescriptionComponentHandler.Input.self, from: data) else {
            return "Error with decoding"
        }
        return input.description
    }
    
    public func getCache() -> Data? {
        return nil
    }
}
