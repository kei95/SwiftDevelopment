//
//  ViewController.swift
//  MealTracker
//
//  Created by Yamashtia Keisuke on 2019-08-27.
//  Copyright © 2019 Yamashtia Keisuke. All rights reserved.
//

import UIKit

class MealListTableViewController: UITableViewController {
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        return formatter
    }()

    var meals: [Meal] = [
        Meal(name: "Sashimi", photo: UIImage(named: "sashimi")!, notes: "Row fish, originated from Japan", rating: 10, timestamp: Date()),
        Meal(name: "Churrasco", photo: UIImage(named: "churrasco")!, notes: "Brazilian BBQ, good with orange juice", rating: 10, timestamp: Date()),
        Meal(name: "Feijoada", photo: UIImage(named: "feijoada")!, notes: "Stew make from beans and pork", rating: 10, timestamp: Date()),
        Meal(name: "Kimchi", photo: UIImage(named: "kimchi")!, notes: "Fermented Cabbage in red pepper from Korea", rating: 10, timestamp: Date()),
        Meal(name: "Rulofun", photo: UIImage(named: "mincedporkrice")!, notes: "Most poular Taiwanese dish", rating: 10, timestamp: Date()),
        Meal(name: "Shiokara", photo: UIImage(named: "shiokara")!, notes: "Fermented Squids guts", rating: 10, timestamp: Date())
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MealDetail" {
            let destVC = segue.destination as! MealDetailViewController
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                destVC.meal = meals[selectedIndexPath.row]
            }
        }
    }
    //MARK: UITableViewDataSource - data
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath)
        let meal = meals[indexPath.row]
        cell.textLabel?.text = meal.name
        cell.detailTextLabel?.text = dateFormatter.string(from: Date())
        cell.imageView?.image = meal.photo
        return cell
    }
    
    
    
    
    //MARK: UITableViewDelegate - actions, looks


}

