//
//  RegistrationTableViewController.swift
//  HotelCornerstone
//
//  Created by Yamashtia Keisuke on 2019-09-10.
//  Copyright © 2019 Yamashtia Keisuke. All rights reserved.
//

import UIKit

class RegistrationTableViewController: UITableViewController {
    
    var registrations = [Registration]()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddRegistration" {
            if let destinationNav = segue.destination as? UINavigationController {
                if let destinationVC = destinationNav.topViewController as? AddRegistrationTableViewController {
                    destinationVC.delegate = self
                }
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return registrations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell", for: indexPath)
        
        let registration = registrations[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        cell.textLabel?.text = registration.firstName + " " + registration.lastName
        cell.detailTextLabel?.text = dateFormatter.string(from: registration.checkInDate) + " - " +
            dateFormatter.string(from: registration.checkOutDate) + " : " + registration.roomType.name
        
        return cell
    }
}


extension RegistrationTableViewController: AddRegistrationTableViewControllerDelegate {
    func didAddNewRegistration(_ registration: Registration) {
        self.registrations.append(registration)
        self.tableView.insertRows(at: [IndexPath(row: registrations.count - 1, section: 0)], with: .automatic)
    }
}
