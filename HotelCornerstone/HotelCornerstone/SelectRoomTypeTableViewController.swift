//
//  SelectRoomTypeTableViewController.swift
//  HotelCornerstone
//
//  Created by Yamashtia Keisuke on 2019-09-10.
//  Copyright © 2019 Yamashtia Keisuke. All rights reserved.
//

import UIKit

class SelectRoomTypeTableViewController: UITableViewController {
    
    var roomType: RoomType?
    weak var delegate: SelectRoomTypeTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return RoomType.all.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTypeCells", for: indexPath)
        let roomType = RoomType.all[indexPath.row]
        if roomType == self.roomType {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        cell.textLabel?.text = roomType.name
        cell.detailTextLabel?.text = "$\(roomType.price)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.roomType = RoomType.all[indexPath.row]
        delegate?.didSelect(roomType: roomType!)
        tableView.reloadData()
    }
}

protocol SelectRoomTypeTableViewControllerDelegate: class {
    func didSelect(roomType: RoomType)
}
