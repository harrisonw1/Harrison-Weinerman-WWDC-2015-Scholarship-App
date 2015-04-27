//
//  ViewController.swift
//  Harrison Weinerman
//
//  Created by Harrison Weinerman on 4/14/15.
//  Copyright (c) 2015 Harrison Weinerman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var meHeaderImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var developerTitle: UILabel!
    
    @IBOutlet weak var swipeIndicator: UILabel!

    @IBOutlet weak var embedded: UILabel!
    
    //this function wiggles the label telling you to swipe to move forward
    func indicateSwipability(){
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.swipeIndicator.transform = CGAffineTransformMakeTranslation(25, 0)
            }, completion: { finished in
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.swipeIndicator.transform = CGAffineTransformMakeTranslation(-5, 0)
                    }, completion: { finished in
                        self.indicateSwipability()
                })
        })
    }


    @IBAction func swipe(sender: AnyObject) {
        
        //swipe gesture received, build out contents then go to the menu
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            
            let scale = CGAffineTransformMakeScale(4, 4)
            self.meHeaderImage.transform = scale
            self.nameLabel.transform = scale
            self.developerTitle.transform = scale
            
            }, completion: { finished in
                
        })
        self.performSegueWithIdentifier("presentMenu", sender: self)

    }
    
    override func viewDidAppear(animated: Bool) {
        
        //try to get users on the iphone 6
        if self.view.frame.size.width <= 320 {
            let alert = UIAlertController(title: "Alert", message: "An iPhone 6 or 6 Plus is highly recommended for optimal experinece of my app. Some features may not work or render properly.", preferredStyle: UIAlertControllerStyle.Alert)
            let cancelAction: UIAlertAction = UIAlertAction(title: "Continue anyway", style: .Cancel) { action -> Void in
            }
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        //fade in embedded extensions reminder
        UIView.animateWithDuration(3, animations: { () -> Void in
            self.embedded.alpha = 1
            
        })
        
        //wiggle the thing that tells you to swipe to move forward
        indicateSwipability()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //status bar
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        //setup for fade in of embedded extensions reminder
        embedded.alpha = 0
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        //setup some view details on myself
        meHeaderImage.layer.cornerRadius = meHeaderImage.frame.size.height/2
        meHeaderImage.layer.masksToBounds = true
        meHeaderImage.layer.borderWidth = 1
        meHeaderImage.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        //setup parallax on my head
        var xEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        var yEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
    
        //one shift constant so i can easily adjust
        let shift = 30
        
        xEffect.maximumRelativeValue = shift
        xEffect.minimumRelativeValue = -shift
        
        yEffect.maximumRelativeValue = shift
        yEffect.minimumRelativeValue = -shift
        //add paralx
        meHeaderImage.addMotionEffect(xEffect)
        meHeaderImage.addMotionEffect(yEffect)
        
        
        //setup gradient background
        let gradient = CAGradientLayer()
        
        let colorOne = UIColor(red: 163/255, green: 24/255, blue: 29/255, alpha: 0.6)
        let colorTwo = UIColor(red: 163/255, green: 24/255, blue: 29/255, alpha: 1.0)
        
        gradient.colors = [colorOne.CGColor, colorTwo.CGColor]
        
        gradient.locations = [0.0 , 1.0]
        //for left to right gradient
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        //finally add gradient
        self.view.layer.insertSublayer(gradient, atIndex: 0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

