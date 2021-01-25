//
//  DateFormatter.swift
//  Events
//
//  Created by stanley phillips on 1/22/21.
//

import Foundation

extension DateFormatter {
    static let eventDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}
