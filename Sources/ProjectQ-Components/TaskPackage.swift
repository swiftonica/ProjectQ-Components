//
//  TaskPackage.swift
//  ProjectQ-Components
//
//  Created by Jeytery on 18.02.2023.
//

import Foundation

public struct TaskPackage: Codable {
    public init(tasks: Tasks, name: String) {
        self.tasks = tasks
        self.name = name
    }
    
    public let tasks: Tasks
    public let name: String
}
public typealias TaskPackages = [TaskPackage]
