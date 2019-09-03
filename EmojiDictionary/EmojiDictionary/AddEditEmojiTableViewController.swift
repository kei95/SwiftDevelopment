//
//  AddEditEmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Yamashtia Keisuke on 2019-08-30.
//  Copyright © 2019 Yamashtia Keisuke. All rights reserved.
//

import UIKit

class AddEditEmojiTableViewController: UITableViewController {
    
    var emoji: Emoji?
    
    @IBOutlet var name: UITextField!
    @IBOutlet var symble: UITextField!
    @IBOutlet var usage: UITextField!
    @IBOutlet var descriptionTF: UITextField!
    @IBOutlet var saveBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let emoji = emoji {
            name.text = emoji.symbol
            symble.text = emoji.name
            usage.text = emoji.usage
            descriptionTF.text = emoji.description
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveEmoji"{
            let symbol = symble.text ?? ""
            let nameTF = name.text ?? ""
            let description = descriptionTF.text ?? ""
            let usageTF = usage.text ?? ""
            
            emoji = Emoji(symbol: symbol, name: nameTF, description: description, usage: usageTF)
        }
    }
    
    @IBAction func textEditChanged(_ sender: Any) {
        validateTextFields()
    }
    
    private func validateTextFields() {
        let symbol = symble.text ?? ""
        let nameTF = name.text ?? ""
        let description = descriptionTF.text ?? ""
        let usageTF = usage.text ?? ""
        
        saveBtn.isEnabled = !(symbol.isEmpty && nameTF.isEmpty && description.isEmpty && usageTF.isEmpty)
    }
    
    @IBAction func returnKeyPressed(_ sender: Any) {
        
    }
    
    
    
}
