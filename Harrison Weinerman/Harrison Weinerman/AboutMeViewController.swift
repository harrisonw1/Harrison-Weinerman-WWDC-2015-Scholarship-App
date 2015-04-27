//
//  AboutMeViewController.swift
//  Harrison Weinerman
//
//  Created by Harrison Weinerman on 4/25/15.
//  Copyright (c) 2015 Harrison Weinerman. All rights reserved.
//

import UIKit
import MapKit

class AboutMeViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var chesterMapView: MKMapView!
    
    @IBOutlet weak var myNameIs: UILabel!
    
    @IBOutlet weak var subHeading: UILabel!
    
    @IBOutlet weak var swipeToLearnMore: UILabel!
    
    @IBOutlet weak var mapTitle: UILabel!
    
    @IBOutlet weak var familyImageView: UIImageView!
    
    @IBOutlet weak var familyTitle: UILabel!
    
    @IBOutlet weak var schoolImageView: UIImageView!
    
    @IBOutlet weak var schoolTitle: UILabel!
    
    @IBOutlet weak var collegeImageView: UIImageView!
    
    @IBOutlet weak var collegeTitle: UILabel!
    
    @IBOutlet weak var extracurricularImageView: UIImageView!
    
    @IBOutlet weak var extracurricularTitle: UILabel!
    
    @IBOutlet weak var theScrollView: UIScrollView!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let cornerRadius : CGFloat = 20
        
        chesterMapView.layer.cornerRadius = cornerRadius
        familyImageView.layer.cornerRadius = cornerRadius
        schoolImageView.layer.cornerRadius = cornerRadius
        collegeImageView.layer.cornerRadius = cornerRadius
        extracurricularImageView.layer.cornerRadius = cornerRadius
        
        backButton.title = "Done"
        forwardButton.title = ""
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Avenir", size: 20)!,  NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        let comeFromBottom = CGAffineTransformConcat(CGAffineTransformMakeTranslation(0, 3000), CGAffineTransformMakeScale(0.1, 0.1))
        let comeFromTop = CGAffineTransformConcat(CGAffineTransformMakeTranslation(0, -3000), CGAffineTransformMakeScale(0.1, 0.1))
        
        //get things out of the way so we can animate to their storyboard positions later
        chesterMapView.transform = comeFromTop
        mapTitle.transform = comeFromBottom
        
        familyImageView.transform = comeFromTop
        familyTitle.transform = comeFromBottom
        
        schoolImageView.transform = comeFromBottom
        schoolTitle.transform = comeFromTop
        
        extracurricularImageView.transform = comeFromTop
        extracurricularTitle.transform = comeFromBottom
        
        collegeImageView.transform = comeFromBottom
        collegeTitle.transform = comeFromTop
        
        myNameIs.transform = comeFromBottom
        subHeading.transform = comeFromTop
        
    }
    
    func prepForBuildIn(comeFromTopObj : AnyObject, comeFromBottomObj : AnyObject){
        let comeFromBottom = CGAffineTransformConcat(CGAffineTransformMakeTranslation(0, 3000), CGAffineTransformMakeScale(0.1, 0.1))
        let comeFromTop = CGAffineTransformConcat(CGAffineTransformMakeTranslation(0, -3000), CGAffineTransformMakeScale(0.1, 0.1))
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            (comeFromTopObj as! UIView).transform = comeFromTop
            (comeFromBottomObj as! UIView).transform = comeFromBottom
        })

    }
    
    
    override func viewDidAppear(animated: Bool) {
        let location = CLLocationCoordinate2D(latitude: 40.816760, longitude: -74.697031)
        let span = MKCoordinateSpanMake(1, 1)
        let region = MKCoordinateRegionMake(location, span)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "My house"
        
        chesterMapView.setRegion(region, animated: true)
        chesterMapView.addAnnotation(annotation)
        
        animateFirstPage()
        
        indicateSwipability()
    }

    func animateFirstPage(){
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.myNameIs.transform = CGAffineTransformIdentity
            self.subHeading.transform = CGAffineTransformIdentity
        })
    }
    
    func indicateSwipability(){
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.swipeToLearnMore.transform = CGAffineTransformMakeTranslation(25, 0)
            }, completion: { finished in
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.swipeToLearnMore.transform = CGAffineTransformMakeTranslation(-5, 0)
                    }, completion: { finished in
                        self.indicateSwipability()
                })
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {

        
        if theScrollView.contentOffset.x == 0 {
            //Not at last page
            forwardButton.title = ""
        }
        else {
            //At last page
            forwardButton.title = "Done"
        }
        
        if theScrollView.contentOffset.x > 0 {
            //we're not at the beginning and can go back
            backButton.title = "Previous"
        }
        else {
            //at the beginning and we want done on the left
            backButton.title = "Done"
        }
        
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func goToThePage(scrollView : UIScrollView){
        
        if scrollView.contentOffset.x < 225 {
            //go to home
            theScrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y), animated: true)
            animateFirstPage()
        }
        
        let buildInTime = 0.5
        let delayTime = 0.01
        
        //measuring inset to determine pagination and animation
        
        if scrollView.contentOffset.x > 225 && scrollView.contentOffset.x <= 609 {
            //go to map
            theScrollView.setContentOffset(CGPoint(x: 510, y: scrollView.contentOffset.y), animated: true)
            
            delay(delayTime){
                UIView.animateWithDuration(buildInTime, animations: { () -> Void in
                    self.mapTitle.transform = CGAffineTransformIdentity
                    self.chesterMapView.transform = CGAffineTransformIdentity
                })
                self.prepForBuildIn(self.myNameIs, comeFromBottomObj: self.subHeading)
            }
        }
        
        if scrollView.contentOffset.x > 609 && scrollView.contentOffset.x <= 921 {
            //go to family
            theScrollView.setContentOffset(CGPoint(x: 821, y: scrollView.contentOffset.y), animated: true)
            delay(delayTime){
                UIView.animateWithDuration(buildInTime, animations: { () -> Void in
                    self.familyImageView.transform = CGAffineTransformIdentity
                    self.familyTitle.transform = CGAffineTransformIdentity
                })
                self.prepForBuildIn(self.chesterMapView, comeFromBottomObj: self.mapTitle)

            }
        }
        
        if scrollView.contentOffset.x > 921 && scrollView.contentOffset.x <= 1249 {
            //go to school
            theScrollView.setContentOffset(CGPoint(x: 1133, y: scrollView.contentOffset.y), animated: true)
            delay(delayTime){
                UIView.animateWithDuration(buildInTime, animations: { () -> Void in
                    self.schoolImageView.transform = CGAffineTransformIdentity
                    self.schoolTitle.transform = CGAffineTransformIdentity
                })
                self.prepForBuildIn(self.familyImageView, comeFromBottomObj: self.familyTitle)
            }
        }
        
        if scrollView.contentOffset.x > 1249 && scrollView.contentOffset.x <= 1615 {
            //go to extracurriculars
            theScrollView.setContentOffset(CGPoint(x: 1519, y: scrollView.contentOffset.y), animated: true)
            delay(delayTime){
                UIView.animateWithDuration(buildInTime, animations: { () -> Void in
                    self.extracurricularImageView.transform = CGAffineTransformIdentity
                    self.extracurricularTitle.transform = CGAffineTransformIdentity
                })
                self.prepForBuildIn(self.schoolTitle, comeFromBottomObj: self.schoolImageView)
                self.prepForBuildIn(self.collegeTitle, comeFromBottomObj: self.collegeImageView)

            }
        }
        
        if scrollView.contentOffset.x > 1615 {
            //go to college
            theScrollView.setContentOffset(CGPoint(x: 1828, y: scrollView.contentOffset.y), animated: true)
            delay(delayTime){
                UIView.animateWithDuration(buildInTime, animations: { () -> Void in
                    self.collegeImageView.transform = CGAffineTransformIdentity
                    self.collegeTitle.transform = CGAffineTransformIdentity
                })
                self.prepForBuildIn(self.extracurricularImageView, comeFromBottomObj: self.extracurricularTitle)
            }
        }

        
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        goToThePage(scrollView)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        goToThePage(scrollView)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        goToThePage(scrollView)
    }
    
    @IBAction func nextPushed(sender: AnyObject) {
        
        if theScrollView.contentOffset.x < 1828 {
            //Not at last page
            self.performSegueWithIdentifier("aboutMeToMenu", sender: self)
        }
        else {
            //At last page
            self.performSegueWithIdentifier("aboutMeToMenu", sender: self)
        }
        
        
    }
    
    @IBAction func previousPushed(sender: AnyObject) {
        if theScrollView.contentOffset.x > 0 {
            theScrollView.setContentOffset(CGPoint(x: theScrollView.contentOffset.x - 320, y: 0), animated: true)
        }
        else {
            self.performSegueWithIdentifier("aboutMeToMenu", sender: self)
        }
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
