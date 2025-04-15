//
//  LiveActivities.swift
//  Shopping List
//
//  Created by Gustavo Yud on 01/04/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

public struct LiveActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        public let itemsCompleted: Int
        public let listLength: Int
        public let nextItem: String?
    }
    public var listName: String
    public var icon: String
}
