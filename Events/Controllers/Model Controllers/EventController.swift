//
//  EventController.swift
//  Events
//
//  Created by stanley phillips on 1/22/21.
//

import CoreData

class EventController {
    // MARK: - Properties
    static var shared = EventController()
    let notificationScheduler = NotificationScheduler()
    
    var sectionedEvents: [[Event]] {[attending, notAttending]}
    var attending: [Event] = []
    var notAttending: [Event] = []
    
    private lazy var fetchRequest: NSFetchRequest<Event> = {
        let request = NSFetchRequest<Event>(entityName: "Event")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    // MARK: - CRUD
    func createEventWith(title: String, date: Date) {
        let newEvent = Event(title: title, date: date)
        attending.append(newEvent)
        notificationScheduler.scheduleNotification(event: newEvent)
        CoreDataStack.saveContext()
    }
    
    func fetchEvents() {
        let events = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        attending = events.filter({$0.amAttending})
        notAttending = events.filter({!$0.amAttending})
    }
    
    func update(event: Event, title: String, date: Date) {
        event.title = title
        event.date = date
        event.amAttending = true
        notificationScheduler.cancelNotification(event: event)
        notificationScheduler.scheduleNotification(event: event)
        CoreDataStack.saveContext()
    }
    
    func toggleAmAttending(event: Event) {
        event.amAttending.toggle()
        if event.amAttending {
            if let index = notAttending.firstIndex(of: event) {
                notAttending.remove(at: index)
                attending.append(event)
                notificationScheduler.scheduleNotification(event: event)
            }
        } else {
            if let index = attending.firstIndex(of: event) {
                attending.remove(at: index)
                notAttending.append(event)
                notificationScheduler.cancelNotification(event: event)
            }
        }
        CoreDataStack.saveContext()
    }
    
    func delete(event: Event) {
        if let index = attending.firstIndex(of: event){
            attending.remove(at: index)
        } else if let index = notAttending.firstIndex(of: event) {
            notAttending.remove(at: index)
        }
        notificationScheduler.cancelNotification(event: event)
        CoreDataStack.context.delete(event)
        CoreDataStack.saveContext()
    }
}
