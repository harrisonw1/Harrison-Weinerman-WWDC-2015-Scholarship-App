//
//  WWDCDetailsViewController.swift
//  Harrison Weinerman
//
//  Created by Harrison Weinerman on 4/26/15.
//  Copyright (c) 2015 Harrison Weinerman. All rights reserved.
//

import UIKit

class WWDCDetailsViewController: UIViewController {

    @IBOutlet weak var line1: UILabel!
    
    @IBOutlet weak var line2: UILabel!
    
    @IBOutlet weak var line3: UILabel!

    @IBOutlet weak var line4: UILabel!

    @IBOutlet weak var line5: UILabel!
    
    @IBOutlet weak var line6: UILabel!
    
    @IBOutlet weak var line7: UILabel!
    
    @IBOutlet weak var funfact: UILabel!
    
    @IBOutlet weak var continueButton: UIButton!
    
    
    @IBAction func `continue`(sender: AnyObject) {
        self.performSegueWithIdentifier("wwdcfinale", sender: self)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let prepareForAnimation = CGAffineTransformConcat(CGAffineTransformMakeScale(0.01, 0.01), CGAffineTransformMakeTranslation(300, 0))
        line1.transform = prepareForAnimation
        line2.transform = prepareForAnimation
        line3.transform = prepareForAnimation
        line4.transform = prepareForAnimation
        line5.transform = prepareForAnimation
        line6.transform = prepareForAnimation
        line7.transform = prepareForAnimation
        funfact.transform = prepareForAnimation
        
        continueButton.layer.borderColor = UIColor.whiteColor().CGColor
        continueButton.layer.borderWidth = 1
        continueButton.layer.cornerRadius = 4
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(2, animations: { () -> Void in
            self.line1.transform = CGAffineTransformIdentity
        })
        
        UIView.animateWithDuration(2, delay: 2, options: nil, animations: { () -> Void in
            self.line2.transform = CGAffineTransformIdentity
        }, completion: nil)
        
        UIView.animateWithDuration(2, delay: 3, options: nil, animations: { () -> Void in
            self.line3.transform = CGAffineTransformIdentity
            }, completion: nil)
        
        UIView.animateWithDuration(2, delay: 5, options: nil, animations: { () -> Void in
            self.line4.transform = CGAffineTransformIdentity
            }, completion: nil)
        
        UIView.animateWithDuration(2, delay: 5.5, options: nil, animations: { () -> Void in
            self.line5.transform = CGAffineTransformIdentity
            }, completion: nil)
        
        UIView.animateWithDuration(2, delay: 6, options: nil, animations: { () -> Void in
            self.line6.transform = CGAffineTransformIdentity
            }, completion: nil)
        
        UIView.animateWithDuration(2, delay: 6.5, options: nil, animations: { () -> Void in
            self.line7.transform = CGAffineTransformIdentity
            }, completion: nil)
        
        
        UIView.animateWithDuration(2, delay: 8, options: nil, animations: { () -> Void in
            self.funfact.transform = CGAffineTransformIdentity
            }, completion: nil)
        
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
