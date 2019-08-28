//
//  AthleteFormViewController.swift
//  FavoriteAthlete
//
//  Created by Yamashtia Keisuke on 2019-08-27.
//

import UIKit

class AthleteFormViewController: UIViewController {
    
    var athlete: Athlete?
    
    @IBOutlet var nameForm: UITextField!
    @IBOutlet var ageForm: UITextField!
    @IBOutlet var leagueForm: UITextField!
    @IBOutlet var teamForm: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        // Do any additional setup after loading the view.
    }
    
    func updateView() {
        if let athlete = athlete {
            nameForm.text = athlete.name
            ageForm.text = athlete.age
            leagueForm.text = athlete.league
            teamForm.text = athlete.team
        }
    }
    

    @IBAction func saveBtnTapped(_ sender: Any) {
        guard let name = nameForm.text,
        let age = ageForm.text,
        let league = leagueForm.text,
        let team = teamForm.text else {return}
    
        athlete = Athlete(name: name, age: age, league: league, team: team)
        performSegue(withIdentifier: "unWind", sender: self)
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
