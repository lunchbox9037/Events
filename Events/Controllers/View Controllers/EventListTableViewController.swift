//
//  EventListTableViewController.swift
//  Events
//
//  Created by stanley phillips on 1/22/21.
//

import UIKit

class EventListTableViewController: UITableViewController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        EventController.shared.fetchEvents()
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return EventController.shared.sectionedEvents.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventController.shared.sectionedEvents[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var header = ""
        if section == 0 {
            if EventController.shared.attending.count > 0 {
                header = "Attending"
            }
        } else if section == 1 {
            if EventController.shared.notAttending.count > 0 {
                header = "Not Attending"
            }
        }
        return header
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventTableViewCell else {return UITableViewCell()}
        
        cell.delegate = self
        cell.event = EventController.shared.sectionedEvents[indexPath.section][indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let eventToDelete = EventController.shared.sectionedEvents[indexPath.section][indexPath.row]
            EventController.shared.delete(event: eventToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEventDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? EventDetailViewController else {return}
            let eventToSend = EventController.shared.sectionedEvents[indexPath.section][indexPath.row]
            destination.event = eventToSend
        }
    }
}

// MARK: - Custom Cell Delegate Methods
extension EventListTableViewController: AttendingButtonDelegate {
    func attendingButtonToggled(_ sender: EventTableViewCell) {
        guard let event = sender.event else {return}
        EventController.shared.toggleAmAttending(event: event)
        sender.updateCells()
        tableView.reloadData()
    }
}
