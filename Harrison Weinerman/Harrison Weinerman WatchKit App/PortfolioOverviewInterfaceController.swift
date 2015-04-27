//
//  PortfolioOverviewInterfaceController.swift
//  Harrison Weinerman
//
//  Created by Harrison Weinerman on 4/26/15.
//  Copyright (c) 2015 Harrison Weinerman. All rights reserved.
//

import WatchKit
import Foundation


class PortfolioOverviewInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var table: WKInterfaceTable!
    
    var projects : [String]!
    var details : [String]!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        //setup project data, will select on details view based on what's passed in the context later
        
        projects = ["Keypad", "Calc", "Codebox", "Mendham HS", "L&W Connect", "Older Projects"]
        
        details = ["I co-developed Keypad, with fellow WWDC 2014 scholar Eytan Schulman. Keypad is a dedicated dialer for OS X. It makes using continuity to place calls through your iPhone even easier. Keypad has been featured in The Verge, 9to5 Mac, iDownloadBlog, Lifehacker and even was named \"Mac Communications App of the Year\" by iMore.\n\n– Beautiful transparent design\n– Dial numbers that aren't in your contacts\n– Redial the last number\n– Save a number to your contacts\n– Search your contacts by starting to type a name (optional)\n– Use letter keys to dial vanity numbers (optional)\n– Dial tones (optional). \n \n Keypad is also coming to iPad! It is almost done and will bring all the features of the OS X app, and more, to iPad (and eventually iPhone as an alternative to Phone.app) with iCloud sync.", "Getting ready for Apple Watch, I realized ther was no built in calculator app which could be incredibly useful. So I mad myown. Calc. It's currently waiting for review for the App Store, and is open source too! On iPhone it's a beautiful calculator with the four main operators (+, -, x, ÷), and on Apple Watch, it fits the same functionality into a smaller display. Operators are displayed contextually with force touch to save space and make room for larger, still easy to press number buttons. It as a fun project to get started with Apple Watch programming and I hope others get to enjoy it or even learn from it's source!", "At MHacks V, my team and I developed Codebox: an Objective-C interpretor for iOS. It uses NSInvocation to dynamically create real Objective-C classes at runtime and execute them on the iOS device. It also includes syntax highlighting, of course. It could be useful to experienced develoeprs who just want to prototype a cool new idea for an animation, all the way to beginners who just want to experiment like in Swift playgrounds, but on their iPhone or iPad (and in Objective-C).", "I developed an app for my high school. Students can use it to see which class is next based on the rotating bell schedule, daily announcements, and more. You can also access the faculty directory and school calendar. \n Over 2/3 of students have the app installed on their iPhone, and there are hundreds of daily active users, especially helping incoming freshman adapt to a new schedule, school, and high school life!", "In July 2013, I was contracted by Lake and Wetland Management, a Florida based franchise with over 15 offices across the southeast US that specializes in maintaining and treating artificial lakes and wetland areas, to develop an iPad app for their field techs. Customer service is incredible important to Lake and Wetland, and the app allows field reports to be easily filed and accessed remotely, integrating with their customer database and the Aplicor 3C API. Customers get isntant email feedback on what services are done, and it makes it easier to account for all employee actions as well. Lake and Wetland Connect was built for internal use only and is not available on the App Store.", "I began developing apps the summer of 2012, starting with Computer Acronyms: a simple reference app for common technology abbreviations. I later made Photo Tips which gave tips on photography. While the usability of these proejcts are long gone, it's fun to see how far I've come and how much those simple projects have inspired me to continue learning about programming and app development."]

        //fill the able
        
        table.setNumberOfRows(projects.count, withRowType: "portfolio") 
        
        for index in 0..<projects.count {
            let row = table.rowControllerAtIndex(index) as! portfolioObj
            row.titleLabel.setText(projects[index])
        }
    
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        //push to details view and pass in what we want to use
        self.pushControllerWithName("portfolioDetails", context: ["title" : projects[rowIndex], "details" : details[rowIndex
        ]])
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
