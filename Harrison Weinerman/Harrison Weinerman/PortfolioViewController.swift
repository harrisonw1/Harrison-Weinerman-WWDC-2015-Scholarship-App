//
//  PortfolioViewController.swift
//  Harrison Weinerman
//
//  Created by Harrison Weinerman on 4/15/15.
//  Copyright (c) 2015 Harrison Weinerman. All rights reserved.
//

import UIKit

class PortfolioViewController: UIViewController, UICollectionViewDelegate {
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    
    var imageArray : [UIImage] = []
    var titleArray : [String] = []
    var shortArray : [String] = []
    
    var topIsFlipped : Bool!
    
    var selectedIndex : Int!

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var testImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup data arrays

        imageArray.append(UIImage(named: "keypad.png")!)
        imageArray.append(UIImage(named: "calc.png")!)
        imageArray.append(UIImage(named: "codebox2.png")!)
        imageArray.append(UIImage(named: "mendham.png")!)
        imageArray.append(UIImage(named: "lake")!)
        imageArray.append(UIImage(named: "old.png")!)

        titleArray.append("Keypad for OS X")
        titleArray.append("Calc for iPhone and Apple Watch")
        titleArray.append("Codebox Obj-C Interpretor")
        titleArray.append("Mendham HS")
        titleArray.append("Lake and Wetland Connect")
        titleArray.append("Older Projects")

        shortArray.append("keypad")
        shortArray.append("calc")
        shortArray.append("codebox")
        shortArray.append("mendham")
        shortArray.append("lake")
        shortArray.append("other")
        
        collectionView.collectionViewLayout.invalidateLayout()
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Avenir", size: 20)!,  NSForegroundColorAttributeName: UIColor.whiteColor()]

            }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            
            return CGSize(width: self.view.frame.size.width, height: 383)
            
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        println("Scroll view scrolled to \(scrollView.contentOffset)")
        
    }

    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! PorfolioOverviewCollectionViewCell
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            cell.backgroundImage.transform = CGAffineTransformMakeScale(0.7, 0.7)
        })
        
    }
    
    func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! PorfolioOverviewCollectionViewCell
  
        UIView.animateWithDuration(0.15, animations: { () -> Void in
            cell.backgroundImage.transform = CGAffineTransformMakeScale(1.2, 1.2)
        })
        
        UIView.animateWithDuration(0.15, delay: 0.15, options: nil, animations: { () -> Void in
            cell.backgroundImage.transform = CGAffineTransformMakeScale(0.9, 0.9)
            }, completion: nil)
        UIView.animateWithDuration(0.08, delay: 0.3, options: nil, animations: { () -> Void in
            cell.backgroundImage.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }, completion: nil)
        
    }
    
    
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {


        
        UIView.animateWithDuration(0.5, animations: { () -> Void in

            let trans = CGAffineTransformMakeTranslation(-500, 0)
            let scale = CGAffineTransformMakeScale(0.88, 0.88)
            let both = CGAffineTransformConcat(trans, scale)
            
            collectionView.transform = both

            }, completion: { finished in
                self.selectedIndex = indexPath.item
                self.performSegueWithIdentifier("portfolioDetail", sender: self)
                
        })
        
        println("\(titleArray[indexPath.item])selected")
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : PorfolioOverviewCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! PorfolioOverviewCollectionViewCell
        
        cell.backgroundImage.image = imageArray[indexPath.item]
        cell.titleLabel.text = titleArray[indexPath.item]
        
        let gradient = CAGradientLayer()
        let colorOne = UIColor.clearColor()
        let colorTwo = UIColor.blackColor()
        
        gradient.colors = [colorOne.CGColor, colorTwo.CGColor]
        
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = cell.gradientView.bounds

        cell.gradientView.layer.sublayers = nil
        
        cell.gradientView.layer.insertSublayer(gradient, below:cell.titleLabel.layer)

        
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //pass info into the details viwe
        if let dest = segue.destinationViewController as? PortfolioDetailViewController {

            dest.appTitle = titleArray[selectedIndex]
            dest.appShortName = shortArray[selectedIndex]
            dest.theHeroImage = UIImage(named: "code.png")!
            dest.learnMoreURL = "http://harrison.click"
            
        }
        
        
    }


}

