//
//  MealDetailViewController.swift
//  MealTracker
//
//  Created by Yamashtia Keisuke on 2019-08-27.
//  Copyright © 2019 Yamashtia Keisuke. All rights reserved.
//

import UIKit
import Foundation

class MealDetailViewController: UIViewController {
    
    var meal: Meal?
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        return formatter
    }()
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    fileprivate func updateUI(_ meal: Meal) {
        photoImageView.image = meal.photo
        nameLabel.text = meal.name
        ratingLabel.text = String(meal.rating)
        timeLable.text = dateFormatter.string(from: Date())
        notesLabel.text = meal.notes
        self.title = meal.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let meal = meal {
            updateUI(meal)
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
