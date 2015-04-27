//
//  TodayViewController.swift
//  Harrison Weinerman Today View
//
//  Created by Harrison Weinerman on 4/26/15.
//  Copyright (c) 2015 Harrison Weinerman. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func refresh(sender: AnyObject) {
        //we want to refresh when the button is pushed
        setARandomFact()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        //set a random fact when it loads
        setARandomFact()
    }
    
    func setARandomFact(){
        
        let facts : [String] = ["I'm 16 years old.", "Keypad has been downloaded tens of thousands of times.", "I have a 42mm Milanese Loop  Watch.", "I <3 Swift.", "WWDC is awesome.", "I've been developing apps since 2010"]
        
        titleLabel.text = facts[randRange(0, upper: facts.count-1)]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func randRange (lower: Int , upper: Int) -> Int {
        //get a random value to search the array for and fill our label
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        //we want to update whenever is possible
        
        setARandomFact()
        //always new data
        completionHandler(NCUpdateResult.NewData)
    }
    
}
