//
//  AddRegistrationTableViewController.swift
//  HotelCornerstone
//
//  Created by Yamashtia Keisuke on 2019-09-09.
//  Copyright © 2019 Yamashtia Keisuke. All rights reserved.
//

import UIKit

protocol AddRegistrationTableViewControllerDelegate: class {
    func didAddNewRegistration(_ registration: Registration)
}

class AddRegistrationTableViewController: UITableViewController {
    
    weak var delegate: AddRegistrationTableViewControllerDelegate?
    
    @IBOutlet var fistNameTF: UITextField!
    @IBOutlet var lastNameTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var checkInDateLB: UILabel!
    @IBOutlet var checkOutDateLB: UILabel!
    @IBOutlet var checkInDatePicker: UIDatePicker!
    @IBOutlet var checkOutDatePicker: UIDatePicker!
    @IBOutlet var numberOfAdultLabel: UILabel!
    @IBOutlet var numberOfChildrenLabel: UILabel!
    @IBOutlet var numberOfAdultStepper: UIStepper!
    @IBOutlet var numberOfChildrenStepper: UIStepper!
    @IBOutlet var wifiSwitch: UISwitch!
    @IBOutlet var roomTypeLabel: UILabel!

    
    let keyForSegue = "SelectRoomType"
    
    var roomType: RoomType?
    
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    
    let checkInDateLableCellIndexPath = IndexPath(row: 0, section: 1)
    let checkOutDateLableCellIndexPath = IndexPath(row: 2, section: 1)
    
    
    var isCheckInDatePickerShown: Bool = false {
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerShown
        }
    }
    var isCheckOutDatePickerShown: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial value for DatePicker
        let midNightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midNightToday
        checkInDatePicker.date = midNightToday
        
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(86400) // 24 hours in secounds
        updateNumberOfGuest()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == keyForSegue {
            if let destinationVC = segue.destination as?
                SelectRoomTypeTableViewController {
                destinationVC.delegate = self
                destinationVC.roomType = self.roomType
            }
        }
    }
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func updateDateViews() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        checkInDateLB.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLB.text = dateFormatter.string(from: checkOutDatePicker.date)
    }

    @IBAction func doneBarBtnTapped(_ sender: Any) {
        let firstName = fistNameTF.text ?? ""
        let lastName = lastNameTF.text ?? ""
        let email = emailTF.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let hasWifi = wifiSwitch.isOn
        
        guard let roomType = roomType else { return }
        
        let registration = Registration(firstName: firstName, lastName: lastName, emailAdress: email, checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfAdult: String(numberOfAdults), numberOfChildren: String(numberOfChildren), roomType: roomType, wifi: hasWifi)
        delegate?.didAddNewRegistration(registration)
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    private func updateNumberOfGuest() {
        numberOfAdultLabel.text = "\(Int(numberOfAdultStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
    
    @IBAction func stepperValueChanged(_ sender: Any) {
        updateNumberOfGuest()
    }
    
    @IBAction func wifiSwitchChanged(_ sender: Any) {
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath:
            if isCheckInDatePickerShown {
                return 216.0
            } else {
                return 0
            }
        case checkOutDatePickerCellIndexPath:
            if isCheckOutDatePickerShown {
                return 216.0
            } else {
                return 0
            }
        default:
            return 44.0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath {
        case checkInDateLableCellIndexPath:
            if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
            } else if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
                isCheckInDatePickerShown = true
            } else {
                isCheckInDatePickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
            
        case checkOutDateLableCellIndexPath:
            if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
            } else if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
                isCheckOutDatePickerShown = true
            } else {
                isCheckOutDatePickerShown = true
            }
            // You will update the tableView with a pair of .beginUpdates()
            // and .endUpdates() calls. These two calls tell the tableView to
            // re-query its attributes -- including cell height.
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            break
        }
    }
}


extension AddRegistrationTableViewController: SelectRoomTypeTableViewControllerDelegate {
    func didSelect(roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    
    fileprivate func updateRoomType() {
        if let roomType = self.roomType {
            roomTypeLabel.text = roomType.name
        } else {
            roomTypeLabel.text = "Not Set"
        }
    }
}
