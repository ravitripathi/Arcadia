//
//  StorageBackedKeys.swift
//  Arcadia
//
//  Created by Ravi Tripathi on 16/01/21.
//

import Foundation
import WidgetKit

class StorageBackedKeys {
    @Storage(key: "lastRunDate", defaultValue: Date())
    static var lastRunDate: Date {
        didSet {
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
}
