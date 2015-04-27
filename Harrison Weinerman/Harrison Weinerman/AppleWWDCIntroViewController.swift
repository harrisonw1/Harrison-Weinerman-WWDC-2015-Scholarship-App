//
//  AppleWWDCIntroViewController.swift
//  Harrison Weinerman
//
//  Created by Harrison Weinerman on 4/25/15.
//  Copyright (c) 2015 Harrison Weinerman. All rights reserved.
//

import UIKit

class AppleWWDCIntroViewController: UIViewController {
    
    @IBOutlet weak var everSince: UILabel!
    
    @IBOutlet weak var iveBeen: UILabel!
    
    @IBOutlet weak var fan: UILabel!
    
    @IBOutlet weak var apple: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var elastic : UIDynamicItemBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //prep for animations back to identity positions
        let prepLeft = CGAffineTransformConcat(CGAffineTransformMakeTranslation(-1000, -200), CGAffineTransformMakeScale(0.3, 0.3))
        let prepRight = CGAffineTransformConcat(CGAffineTransformMakeTranslation(1000, 200), CGAffineTransformMakeScale(0.3, 0.3))
        
        everSince.transform = prepLeft
        iveBeen.transform = prepLeft
        fan.transform = prepRight
        apple.transform = prepRight
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Avenir", size: 20)!,  NSForegroundColorAttributeName: UIColor.whiteColor()]
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        //animate in everything

        UIView.animateWithDuration(2, animations: { () -> Void in
            self.everSince.transform = CGAffineTransformIdentity
        })
        delay(2){
            UIView.animateWithDuration(2, animations: { () -> Void in
                self.iveBeen.transform = CGAffineTransformIdentity
            })
        }
        delay(3){
            UIView.animateWithDuration(2, animations: { () -> Void in
                self.apple.transform = CGAffineTransformIdentity
            })
        }
        delay(4){
            UIView.animateWithDuration(2, animations: { () -> Void in
                self.fan.transform = CGAffineTransformIdentity
            })
        }
        delay(6){
            //drop them with physics. so cool. $w@g
            let array = [self.everSince, self.iveBeen, self.apple, self.fan]
            
            let collision = UICollisionBehavior(items: array)
            collision.translatesReferenceBoundsIntoBoundary = true
            
            let push = UIPushBehavior(items: array, mode: UIPushBehaviorMode.Continuous)
            
            self.elastic = UIDynamicItemBehavior(items: array)
            self.elastic.elasticity = 0.5
            
            self.gravity = UIGravityBehavior(items: array)
            self.gravity.magnitude = 1
            
            push.setAngle( CGFloat(M_PI / 2) , magnitude: 1);
            
            self.animator = UIDynamicAnimator(referenceView: self.view)
            self.animator.addBehavior(collision)
            self.animator.addBehavior(push)
            self.animator.addBehavior(self.gravity)
            self.animator.addBehavior(self.elastic)
    
        }
        delay(9){
            self.performSegueWithIdentifier("goToWWDCInfo", sender: self)

//            UIView.animateWithDuration(1.5, animations: { () -> Void in
            
//            })
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //same delay function is cool, not required though w/ uiview animate bc the func signature with delay call in it
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
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
