//
//  ViewController.swift
//  AppEventCount
//
//  Created by Yamashtia Keisuke on 2019-08-26.
//  Copyright © 2019 Yamashtia Keisuke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var didFinishLaunchingLabel: UILabel!
    @IBOutlet weak var willResignActiveLabel: UILabel!
    @IBOutlet weak var didEnterBackgroundLabel: UILabel!
    @IBOutlet weak var willEnterForgroundLabel: UILabel!
    @IBOutlet weak var didBecomeActiveLabel: UILabel!
    @IBOutlet weak var willTerminateLabel: UILabel!
    
    var launchCount = 0
    var resignActiveCount = 0
    var didEnterForegroundCount = 0
    var willEnterForgroundCount = 0
    var didBecomeActiveCount = 0
    var willTerminateCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
        updateUI()
    }

    func updateUI() {
        didFinishLaunchingLabel.text = "The app has launched \(launchCount) times"
        willResignActiveLabel.text = "applicationWillResignActive has been called \(resignActiveCount) times"
        didEnterBackgroundLabel.text = "applicationDidEnterBackground has been called \(didEnterForegroundCount) times"
        willEnterForgroundLabel.text = "applicationWillEnterForeground has been called \(willEnterForgroundCount) times"
        didBecomeActiveLabel.text = "applicationDidBecomeActive has been called \(didBecomeActiveCount) times"
        willTerminateLabel.text = "applicationWillTerminate has been called \(willTerminateCount) times"
    }

}

