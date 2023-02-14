//
//  IntervalComponent.swift
//  ProjectQ-Components
//
//  Created by Jeytery on 13.02.2023.
//

import Foundation

fileprivate func dayNumberOfWeek(date: Date) -> Int? {
    return Calendar.current.dateComponents([.weekday], from: date).weekday
}

fileprivate func dayOfWeek(date: Date) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter.string(from: date).capitalized
}

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

struct IntervalComponentHandlerInput: Codable {
    public init(
        intervalType: IntervalComponentHandlerInput.IntervalType,
        time: Date,
        lastDate: Date
    ) {
        self.intervalType = intervalType
        self.time = time
        self.lastDate = lastDate
    }

    public struct WeekDay: Codable, CaseIterable {
        public let index: Int
        public let name: String
        
        public static let sat = WeekDay(index: 0, name: "Saturday")
        public static let sun = WeekDay(index: 1, name: "Sunday")
        
        public static let mon = WeekDay(index: 2, name: "Monday")
        public static let tue = WeekDay(index: 3, name: "Tuesday")
        public static let wed = WeekDay(index: 4, name: "Wednesday")
        public static let thu = WeekDay(index: 5, name: "Thursday")
        public static let fri = WeekDay(index: 6, name: "Friday")
        
        public static var allCases: [IntervalComponentHandlerInput.WeekDay] = [
            .mon, .tue, .wed, .thu, .fri, .sat, .sun
        ]
        
        public static func byIndex(_ index: Int) -> WeekDay? {
            return allCases.first { $0.index == index }
        }
        
        public static var today: WeekDay {
            return .byIndex(
                dayNumberOfWeek(date: Date()) ?? 0
            ) ?? .mon
        }
        
        public static var notToday: WeekDay {
            return .byIndex(
                (dayNumberOfWeek(date: Date()) ?? 0) + 1
            ) ?? .mon
        }
    }
    
    public enum IntervalType: Codable {
        case byWeek(WeekDays)
        
        // interval in days
        case interval(Int)
    }
    
    public typealias WeekDays = [WeekDay]

    let intervalType: IntervalType
    let time: Date
    var lastDate: Date
}

class IntervalComponentHandler {
    private var cache: Data?
}

//MARK: - helpers
private extension IntervalComponentHandler {
    func substractDates(lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
    func isToday(_ day: IntervalComponentHandlerInput.WeekDay) -> Bool {
        let today = Date()
        if dayNumberOfWeek(date: today) == day.index {
            return true
        }
        return false
    }
    
    func isNowTimeBigger(_ time: Date) -> Bool {
        let calendar = Calendar.current
        let newDate = Date(timeIntervalSinceReferenceDate: 0)

        let timeDateComponents = calendar.dateComponents([.hour, .minute], from: time)
        let nowDateComponets = calendar.dateComponents([.hour, .minute], from: Date())
        
        if
            let _timeDate = calendar.date(
                byAdding: timeDateComponents,
                to: newDate),
            let _nowDate = calendar.date(
                byAdding: nowDateComponets,
                to: newDate)
        {
            return _nowDate >= _timeDate
        }
        return false
    }
    
    func actualInterval(_ value: Int) -> Int {
        return 0
    }
}

extension IntervalComponentHandler: AppearComponentHandler {
    public func shouldAppear(data: Data) -> Bool {
        guard let input = try? JSONDecoder().decode(IntervalComponentHandlerInput.self, from: data) else {
            return false
        }
        
        switch input.intervalType {
        case .byWeek(let days):
            if !days.filter({ return isToday($0) }).isEmpty, isNowTimeBigger(input.time) {
                return true
            }
            break
            
        case .interval(let interval):
            let nowDate = Date()
            let actualInterval = self.substractDates(lhs: nowDate, rhs: input.lastDate)
            
            if Int(actualInterval / (3600*24)) == interval, isNowTimeBigger(input.time) {
                return true
            }
            break
        }
        return false
    }
    
    func getCache() -> Data {
        return Data()
    }
}