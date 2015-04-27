//
//  WWDCFinaleViewController.swift
//  Harrison Weinerman
//
//  Created by Harrison Weinerman on 4/26/15.
//  Copyright (c) 2015 Harrison Weinerman. All rights reserved.
//

import UIKit

class WWDCFinaleViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var finishButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.alpha = 0
        finishButton.layer.cornerRadius = 5
        finishButton.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        UIView.animateWithDuration(3, animations: { () -> Void in
            self.titleLabel.alpha = 1
            self.titleLabel.transform = CGAffineTransformMakeScale(1.5, 1.5)
        }, completion: nil)
        
        UIView.animateWithDuration(9, delay: 0, options: nil, animations: { () -> Void in
            self.imageView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(2, 2), CGAffineTransformMakeTranslation(0, 500))
        }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func finish(sender: AnyObject) {
        
        self.performSegueWithIdentifier("finish", sender: self)
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
