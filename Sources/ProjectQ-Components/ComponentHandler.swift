//
//  ComponentHandler.swift
//  ProjectQ-Components
//
//  Created by Jeytery on 13.02.2023.
//

import Foundation

public protocol ComponentHandler {
    func getCache() -> Data
}

public protocol AppearComponentHandler: ComponentHandler {
    func shouldAppear(data: Data) -> Bool
}

public protocol DataComponentHandler: ComponentHandler {
    func data(for data: Data) -> String
}

public protocol InteractiveComponentHandler: DataComponentHandler {
    func isDataCorrect(data: Data) -> Bool
    func clear()
}
