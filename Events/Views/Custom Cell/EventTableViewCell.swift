//
//  EventTableViewCell.swift
//  Events
//
//  Created by stanley phillips on 1/22/21.
//

import UIKit

protocol AttendingButtonDelegate: AnyObject {
    func attendingButtonToggled(_ sender: EventTableViewCell)
}

class EventTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var attendingButton: UIButton!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventCellView: UIView!
    
    // MARK: - Properties
    weak var delegate: AttendingButtonDelegate?
    var event: Event? {
        didSet {
            updateCells()
        }
    }
    
    // MARK: - Actions
    @IBAction func attendingButtonTapped(_ sender: Any) {
        delegate?.attendingButtonToggled(self)
    }
    
    // MARK: - Helper Functions
    func updateCells() {
        guard let event = event else {return}
        eventTitleLabel.text = event.title
        eventDateLabel.text = DateFormatter.eventDate.string(from: event.date ?? Date())
        if event.amAttending {
            attendingButton.setImage(UIImage(systemName: "clock.fill"), for: .normal)
            eventCellView.backgroundColor = UIColor.clear
            eventTitleLabel.textColor = UIColor.label
            eventDateLabel.textColor = UIColor.systemBlue
        } else {
            attendingButton.setImage(UIImage(systemName: "clock"), for: .normal)
            eventCellView.backgroundColor = UIColor.systemFill
            eventTitleLabel.textColor = UIColor.systemFill
            eventDateLabel.textColor = UIColor.systemFill
        }
    }
}
