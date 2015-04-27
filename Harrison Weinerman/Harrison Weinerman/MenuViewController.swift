//
//  MenuViewController.swift
//  Harrison Weinerman
//
//  Created by Harrison Weinerman on 4/14/15.
//  Copyright (c) 2015 Harrison Weinerman. All rights reserved.
//

import UIKit
import CoreMotion
import QuartzCore

class MenuViewController: UIViewController {

    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var elastic : UIDynamicItemBehavior!
    var motionManager : CMMotionManager!
    
    @IBOutlet weak var codeImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //used for applying physics
        let array = [about, apps, why]

        //make buttons fit comfortably by fitting to display size
        let maxWidth = self.view.frame.size.width - 10
        let maxHeight = self.view.frame.size.height - 10

        //ratios of sizes
        apps.frame.size = CGSize(width: maxWidth * 0.92, height: maxHeight * 0.25)
        about.frame.size = CGSize(width: maxWidth * 0.5, height: maxHeight * 0.15)
        why.frame.size = CGSize(width: maxWidth * 0.75, height: maxHeight * 0.20)
        
        //make the buttons look nice
        about.layer.cornerRadius = 10
        apps.layer.cornerRadius = 10
        why.layer.cornerRadius = 10
        
        let borderWidth = 2
        
        about.layer.borderColor = UIColor.whiteColor().CGColor
        about.layer.borderWidth = CGFloat(borderWidth)
        
        why.layer.borderColor = UIColor.whiteColor().CGColor
        why.layer.borderWidth = CGFloat(borderWidth)
        
        apps.layer.borderColor = UIColor.whiteColor().CGColor
        apps.layer.borderWidth = CGFloat(borderWidth)

        //cool black gradient along background image
        let gradient = CAGradientLayer()
        let colorOne = UIColor.clearColor()
        let colorTwo = UIColor.blackColor()
        
        gradient.colors = [colorOne.CGColor, colorTwo.CGColor]
        
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = self.view.bounds
        //precaution as was causing crash if added multiple times
        codeImage.layer.sublayers = nil
        
        codeImage.layer.insertSublayer(gradient, atIndex:0)
        
        //woot physics w/ uikit dynaimcs
        //setup a collision with the items made in the array above
        let collision = UICollisionBehavior(items: array)
        collision.translatesReferenceBoundsIntoBoundary = true
        
        
        //setup a push continuousl
        let push = UIPushBehavior(items: array, mode: UIPushBehaviorMode.Continuous)
        
        //bounciness
        elastic = UIDynamicItemBehavior(items: array)
        elastic.elasticity = 0.5
        
        gravity = UIGravityBehavior(items: array)
        gravity.magnitude = 1
        
        push.setAngle( CGFloat(M_PI / 2) , magnitude: 1);
        
        //addbehaviors
        animator = UIDynamicAnimator(referenceView: view)
        animator.addBehavior(collision)
        animator.addBehavior(push)
        animator.addBehavior(gravity)
        animator.addBehavior(elastic)

        //set fonts
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Avenir", size: 20)!,  NSForegroundColorAttributeName: UIColor.whiteColor()]

    }
    
    override func viewDidAppear(animated: Bool) {
    
        //setup motion w/ phys
    motionManager = CMMotionManager()
        
    motionManager.deviceMotionUpdateInterval = 0.03

    motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: {(motionData: CMDeviceMotion!, error:NSError!)in
        
        //set gravity to acceleration from CMAcceleration
    let gravityAccel : CMAcceleration = motionData.gravity

    self.gravity.gravityDirection = CGVectorMake(CGFloat(gravityAccel.x), CGFloat(-gravityAccel.y))
    
    
    
    
    })
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func performBuildOutAndGoToSegueWithIdentifier(identifier : String){
        
        //build out animations
        
        let scale = CGAffineTransformMakeScale(0.5, 0.5)
        let scaleUp = CGAffineTransformMakeScale(4, 4)
        
        
        let transformUp = CGAffineTransformMakeTranslation(0, 50)
        let scaleAndUp = CGAffineTransformConcat(scale, transformUp)
        
        let transformDown = CGAffineTransformMakeTranslation(0, -50)
        let scaleAndDown = CGAffineTransformConcat(scale, transformDown)
        
        let transformLeft = CGAffineTransformMakeTranslation(-50, 0)
        let scaleAndLeft = CGAffineTransformConcat(scale, transformLeft)
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            switch identifier {
            case "apps":
                self.why.transform = scaleAndDown
                self.about.transform = scaleAndLeft
                self.apps.transform = scaleUp
            case "aboutMe":
                self.why.transform = scaleAndDown
                self.about.transform = scaleUp
                self.apps.transform = scaleAndUp
            case "goToWWDC":
                self.why.transform = scaleUp
                self.about.transform = scaleAndLeft
                self.apps.transform = scaleAndUp
            default:
                println("Incorrect segue identifier passed into performBuildOut...")
            }
            
            }, completion: { finished in
                
        })
    
        self.performSegueWithIdentifier(identifier, sender: self)

        
    }
    
    @IBAction func goAbout(sender: AnyObject) {
        performBuildOutAndGoToSegueWithIdentifier("aboutMe")
    }
    
    @IBAction func goWhy(sender: AnyObject) {
        performBuildOutAndGoToSegueWithIdentifier("goToWWDC")
    }
   
    
    @IBAction func goApps(sender: AnyObject) {
        performBuildOutAndGoToSegueWithIdentifier("apps")
    }
    
    @IBOutlet weak var about: UIButton!
    @IBOutlet weak var apps: UIButton!
    @IBOutlet weak var why: UIButton!
    @IBOutlet weak var namelabel: UILabel!
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
