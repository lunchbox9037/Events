//
//  EventDetailViewController.swift
//  Events
//
//  Created by stanley phillips on 1/22/21.
//

import UIKit

class EventDetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var eventTitleTextField: UITextField!
    @IBOutlet weak var eventDatePicker: UIDatePicker!
    @IBOutlet weak var createEventLabel: UILabel!
    
    // MARK: - Properties
    var event: Event?
    var date: Date?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func eventDatePickerChanged(_ sender: Any) {
        date = eventDatePicker.date
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = eventTitleTextField.text, !title.isEmpty else {return}
        guard let date = date else {return dateAlert()}
        
        if let event = event {
            EventController.shared.update(event: event, title: title, date: date)
        } else {
            EventController.shared.createEventWith(title: title, date: date)
        }
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper Functions
    func updateViews() {
        guard let eventDetails = event else {return}
        createEventLabel.text = "Update Event"
        eventTitleTextField.text = eventDetails.title
        eventDatePicker.date = eventDetails.date ?? Date()
    }
    
    func dateAlert() {
        let alert = UIAlertController(title: "Whoops", message: "Dont forget to add a date!", preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: "Add Date", style: .default, handler: nil)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(dismissButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
    }
}
