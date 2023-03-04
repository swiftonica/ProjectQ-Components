import Foundation
import UIKit

public protocol InitializableComponentHandler {
    init()
}

public struct ComponentInformation {
    public let name: String
    public let conflictedComponets: [ComponentId]?
    public let componentId: ComponentId
    
    public init(name: String, conflictedComponents: [ComponentId]?, componentId: ComponentId) {
        self.componentId = componentId
        self.name = name
        self.conflictedComponets = conflictedComponents
    }
    
    static let empty = ComponentInformation(name: "", conflictedComponents: nil, componentId: .none)
}

public struct ComponentId: Equatable {
    public let id: Int
    public static let none = ComponentId(id: -1)
    
    public init(id: Int) {
        self.id = id
    }
}

public struct BaseComponent: Codable {
    let id: Int
    let input: Data?
}

public enum HandlerType: String {
    case appear = "Appear Component"
    case data = "Data Compnent"
    case interactive = "Interactive Compnent"

    init(handler: ComponentHandler) {
        switch handler {
        case is AppearComponentHandler: self = .appear
        case is DataComponentHandler: self = .data
        case is InteractiveComponentHandler: self = .interactive
        default: self = .appear
        }
    }
}

public class Component {
    public var handlerType: HandlerType {
        return .init(handler: self.handler as! ComponentHandler)
    }
    
    public let information: ComponentInformation
    public let handler: ComponentHandler.Type
    public var input: Data?
    
    public static func fromBaseComponent(_ baseComponent: BaseComponent) -> Component? {
        return byComponentId(
            componentId: .init(id: baseComponent.id)
        )?
        .inputed(baseComponent.input)
    }
    
    public static func byComponentId(componentId: ComponentId, input: Data? = nil) -> Component? {
        return Component.allComponents.first {
            $0.information.componentId == componentId
        }?
        .inputed(input)
     }

    public init(information: ComponentInformation, handler: ComponentHandler.Type) {
        self.information = information
        self.handler = handler
    }
    
    public func inputed(_ input: Data?) -> Component {
        self.input = input
        return self
    }
    
    public static var allComponents: Components {
        return [.interval, .logicalList, .interactiveList]
    }
}

extension Component: Equatable {
    public static func == (lhs: ProjectQ_Components.Component, rhs: ProjectQ_Components.Component) -> Bool {
        return lhs.information.componentId.id == rhs.information.componentId.id
    }
}

public typealias Components = [Component]
public typealias BaseComponents = [BaseComponent]
