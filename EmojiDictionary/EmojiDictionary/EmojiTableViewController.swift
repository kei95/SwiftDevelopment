//
//  EmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Yamashtia Keisuke on 2019-08-29.
//  Copyright © 2019 Yamashtia Keisuke. All rights reserved.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    private let cellID = "EmojiCell"
    
    var emojis: [Emoji] = {[
        Emoji(symbol: "😀", name: "Grinning Face", description: "A typical smily face", usage: "happiness"),
        Emoji(symbol: "😕", name: "Confused Face", description: "A confused pazzled face", usage: "unsure what to think; displeasure"),
        Emoji(symbol: "😍", name: "Heart eyes", description: "A smily face with hearts for eyes", usage: "love of something; attractive"),
        Emoji(symbol: "👮‍♀️", name: "Police Officer", description: "A police officer wearing a blue cap with a bold badge", usage:"person of authority"),
        Emoji(symbol: "💔", name: "Broken Heart", description: "A red, broken heart", usage: "extreme sadness"),
        Emoji(symbol: "💤", name: "Snore", description: "Three blue \'z\'s", usage: "tired sleepiness"),
        ]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        print(tableView.isEditing)
        print(editing)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return emojis.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1. dequeue resusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        //2.configure the cell
        let emoji = emojis[indexPath.row]
        cell.textLabel?.text = "\(emoji.symbol) - \(emoji.name)"
        cell.detailTextLabel?.text = emoji.description
        cell.showsReorderControl = true
        //3. return the cell
        return cell
    }
    
    // moving row
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = emojis.remove(at: sourceIndexPath.row)
        emojis.insert(movedEmoji, at: destinationIndexPath.row)
        
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row == 0 {
            return .insert
        }
        if indexPath.row % 2 == 0{
            return .none
        } else {
             return .delete
        }
       
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print("accessory button - \(emojis[indexPath.row].symbol)")
    }
    
    // MARK: - Table view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(emojis[indexPath.row].symbol)
    }
    

}
