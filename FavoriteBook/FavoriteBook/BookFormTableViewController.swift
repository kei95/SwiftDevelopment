//
//  BookFormTableViewController.swift
//  FavoriteBooks
//
//  Created by Yamashtia Keisuke on 2019-08-31.
//

import UIKit

class BookFormTableViewController: UITableViewController {
    struct PropertyKeys {
        static let unwind = "UnwindToBookTable"
    }
    
    var book: Book?


    @IBOutlet var titleTF: UITextField!
    @IBOutlet var authorTF: UITextField!
    @IBOutlet var genreTF: UITextField!
    @IBOutlet var lengthTF: UITextField!
    @IBOutlet var saveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView() {
        guard let book = book else {return}
        
        titleTF.text = book.title
        authorTF.text = book.author
        genreTF.text = book.genre
        lengthTF.text = book.length
    }

    @IBAction func saveBtnTapped(_ sender: Any) {
        guard let title = titleTF.text,
            let author = authorTF.text,
            let genre = genreTF.text,
            let length = lengthTF.text else {return}
        
        book = Book(title: title, author: author, genre: genre, length: length)
        performSegue(withIdentifier: PropertyKeys.unwind, sender: self)
    }
}
