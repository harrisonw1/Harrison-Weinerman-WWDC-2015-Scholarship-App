//
//  AboutMeInterfaceController.swift
//  Harrison Weinerman
//
//  Created by Harrison Weinerman on 4/26/15.
//  Copyright (c) 2015 Harrison Weinerman. All rights reserved.
//

import WatchKit
import Foundation


class AboutMeInterfaceController: WKInterfaceController {

    @IBOutlet weak var map: WKInterfaceMap!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        //setup the map of where i live
        let location = CLLocationCoordinate2D(latitude: 40.816760, longitude: -74.697031)
        let span = MKCoordinateSpanMake(1, 1)
        map.setRegion(MKCoordinateRegionMake(location, span))
        map.addAnnotation(location, withPinColor: WKInterfaceMapPinColor.Red)
        
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
