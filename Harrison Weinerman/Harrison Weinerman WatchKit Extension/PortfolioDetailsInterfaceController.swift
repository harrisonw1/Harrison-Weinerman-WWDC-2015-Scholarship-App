//
//  PortfolioDetailsInterfaceController.swift
//  Harrison Weinerman
//
//  Created by Harrison Weinerman on 4/26/15.
//  Copyright (c) 2015 Harrison Weinerman. All rights reserved.
//

import WatchKit
import Foundation


class PortfolioDetailsInterfaceController: WKInterfaceController {

    @IBOutlet weak var textView: WKInterfaceLabel!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        //get the context back
        var theContext = context as! [String : String]

        //just setting the details view
        setTitle(theContext["title"])
        textView.setText(theContext["details"])
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
