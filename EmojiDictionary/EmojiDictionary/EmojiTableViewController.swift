//
//  EmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Yamashtia Keisuke on 2019-08-29.
//  Copyright © 2019 Yamashtia Keisuke. All rights reserved.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    struct SegueIdentifier {
        static let addEmoji = "AddEmoji"
        static let editEmoji = "EditEmoji"
    }
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditEmoji"{
            let indexPath = tableView.indexPathForSelectedRow!
            let emoji = emojis[indexPath.row]
            let navController = segue.destination as! UINavigationController
            let addEditEmojiTVC = navController.topViewController as! AddEditEmojiTableViewController
            
            addEditEmojiTVC.emoji = emoji
        }
    }
    
    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue) {
        if segue.identifier == "SaveEmoji" {
            let sourceVC = segue.source as! AddEditEmojiTableViewController
    
            if let emoji = sourceVC.emoji {
                if let selectedPath = tableView.indexPathForSelectedRow{
                    emojis[selectedPath.row] = emoji
                    tableView.reloadRows(at: [selectedPath], with: .none)
                } else {
                    let newIndexPath = IndexPath(row: emojis.count, section: 0)
                    emojis.append(emoji)
                    tableView.insertRows(at: [newIndexPath], with: .automatic)
                }
            }
        }
    }

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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! EmojiTableViewCell
        //2.configure the cell
        let emoji = emojis[indexPath.row]
        cell.update(with: emoji)
        cell.showsReorderControl = true
        //3. return the cell
        return cell
    }
    
    // moving row
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = emojis.remove(at: sourceIndexPath.row)
        emojis.insert(movedEmoji, at: destinationIndexPath.row)
        
    }
    
    // MARK: - Table view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(emojis[indexPath.row].symbol)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    

    

}
