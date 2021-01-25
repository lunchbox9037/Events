//
//  Event+Convenience.swift
//  Events
//
//  Created by stanley phillips on 1/22/21.
//

import CoreData

extension Event {
    @discardableResult convenience init(title: String, date: Date, amAttending: Bool = true, uuid: String = UUID().uuidString, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.title = title
        self.date = date
        self.amAttending = amAttending
        self.uuid = uuid
    }
}
