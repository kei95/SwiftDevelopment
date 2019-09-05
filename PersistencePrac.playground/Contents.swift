 import UIKit

import Foundation
// Data  Model has to comfirm to 'Codable'
struct Note: Codable {
    let title: String
    let text: String
    let timeStamp: Date
}

let newNotes = [
    Note(title: "Grocery run", text: "Pick up mayonnaise, mustard, lettuce, tomato and pickles.", timeStamp: Date()),
    Note(title: "Study Coding", text: "Make some cool apps!", timeStamp: Date())
]

//2 . Get the Documents directory url (location)

//: .documentDirectory - 'Documents' directory
//: .userDomainMask - user's home folder
let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

//: 3. Create a file name with an extension

let archiveURL =
    documentsDirectory.appendingPathComponent("notes_text")
        .appendingPathExtension("plist")

//: 4. Encode your Codable Object(Note) using Encoder -> Data(bits, bytes)
let propertyListEncoder = PropertyListEncoder()
let retrievedNoteData = try? Data(contentsOf: archiveURL)

if let encodedNote = try?
    propertyListEncoder.encode(newNotes) {
    // Data - a bag of bits
    
//: 5. Write your encoded data to the given url
    try? encodedNote.write(to: archiveURL, options: .noFileProtection)
    
//: 6. Read Data at the given url
    let propertyListDecoder = PropertyListDecoder()
    
//: 7. Decode the retrived data into Cadable(Note Object)
    if let decodeNote = try? propertyListDecoder.decode([Note].self, from: retrievedNoteData!){
        print(decodeNote)
    }
}

//: iOS Sandbox model
//: Each app has its own enviroment where it can create, modify, or delete data -- its own sandbox --
//  but it doesn't have access to outside of the Sandbox
//: The iOS may allow access to resources outside of your app
//  only when your app recives explicit permission from the user

//: Your app has a few directories that it can use to save data.
//: One of those directories is called the 'Documents'
//  directory, and it's where you're allowed to save and modify information related to your app
//: Another app feature of the sandbox security model is that the
//  file path to the Documents directory will change each time your app is loaded into memory.
//: You have to use FileManager class to interact with files in the Documents directory.











