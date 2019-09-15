//
//  EmployeeTypeTableViewController.swift
//  EmployeeRoster
//
//  Created by Yamashtia Keisuke on 2019-09-12.
//

import UIKit

protocol EmployeeDelegate: class {
    func didSelect(employeeType: EmployeeType)
}

class EmployeeTypeTableViewController: UITableViewController {
    
    var employeeType: EmployeeType?
    
    weak var delegate: EmployeeDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EmployeeType.all.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = EmployeeType.all[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCell", for: indexPath)
        
        if employeeType == type {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        cell.textLabel?.text = type.description()
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.employeeType = EmployeeType.all[indexPath.row]
        delegate?.didSelect(employeeType: employeeType!)
        tableView.reloadData()
    }

}
