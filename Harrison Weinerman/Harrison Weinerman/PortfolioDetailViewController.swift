//
//  PortfolioDetailViewController.swift
//  Harrison Weinerman
//
//  Created by Harrison Weinerman on 4/23/15.
//  Copyright (c) 2015 Harrison Weinerman. All rights reserved.
//

import UIKit
import MediaPlayer

class PortfolioDetailViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var heroImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detailsTextView: UITextView!
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
    @IBOutlet weak var gradientView: UIView!
    
    @IBOutlet weak var textGradientView: UIView!

    @IBOutlet weak var topTextGradientView: UIView!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var learnMoreButton: UIButton!
    
    
    var imageGallery : [UIImage]!
    var appTitle : String!
    var details : String!
    var theHeroImage : UIImage!
    var learnMoreURL : String!
    var appShortName : String!
    var overlayView: UIView!
    var imageDetailView: UIView!
    var animator: UIDynamicAnimator!
    var attachmentBehavior : UIAttachmentBehavior!
    var snapBehavior : UISnapBehavior!
    var selectedImage : UIImage!
    var playButtonTranslatedOffScreen : Bool!
    var moviePlayer : MPMoviePlayerController?
    var movieName : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //boolean to know whether it's already been moved off stage
        playButtonTranslatedOffScreen = false
        
        //gradient over the hero image to fade to black
        let gradient = CAGradientLayer()
        let colorOne = UIColor.clearColor()
        let colorTwo = UIColor.blackColor()
        
        gradient.colors = [colorOne.CGColor, colorTwo.CGColor]
        
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame =  gradientView.bounds
        
        gradientView.layer.sublayers = nil
        gradientView.layer.insertSublayer(gradient, below:titleLabel.layer)
        
        //text gradient to fade between
        let textGradient = CAGradientLayer()
        textGradient.colors = [colorOne.CGColor, colorTwo.CGColor]

        textGradient.locations = [0.0 , 1.0]
        textGradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        textGradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        textGradient.frame =  textGradientView.bounds

        textGradientView.layer.insertSublayer(textGradient, atIndex:0)
        
        let topTextGradient = CAGradientLayer()
        topTextGradient.colors = [colorTwo.CGColor, colorOne.CGColor]
        
        topTextGradient.locations = [0.0 , 1.0]
        topTextGradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        topTextGradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        topTextGradient.frame =  topTextGradientView.bounds

        topTextGradientView.layer.insertSublayer(topTextGradient, atIndex:0)
        
        //make button pretty
        learnMoreButton.layer.borderColor = UIColor.whiteColor().CGColor
        learnMoreButton.layer.borderWidth = 1
        learnMoreButton.layer.cornerRadius = 5
        
        playButton.layer.cornerRadius = playButton.frame.size.width / 2
        
        //figure out what data to get out
        switch appShortName {
        case "keypad":
            imageGallery = [UIImage(named: "keypad.png")!, UIImage(named: "keypad2.png")!, UIImage(named: "keypad3.png")!, UIImage(named: "kphero.png")!]
            details = "I co-developed Keypad, with fellow WWDC 2014 scholar Eytan Schulman. Keypad is a dedicated dialer for OS X. It makes using continuity to place calls through your iPhone even easier. Keypad has been featured in The Verge, 9to5 Mac, iDownloadBlog, Lifehacker and even was named \"Mac Communications App of the Year\" by iMore.\n\n– Beautiful transparent design\n– Dial numbers that aren't in your contacts\n– Redial the last number\n– Save a number to your contacts\n– Search your contacts by starting to type a name (optional)\n– Use letter keys to dial vanity numbers (optional)\n– Dial tones (optional). \n \n Keypad is also coming to iPad! It is almost done and will bring all the features of the OS X app, and more, to iPad (and eventually iPhone as an alternative to Phone.app) with iCloud sync."
            theHeroImage = UIImage(named: "kphero.png")!
            learnMoreURL = "http://getkeypad.co"
            movieName = "keypad"
        case "mendham":
            imageGallery = [UIImage(named: "mendham1.jpeg")!, UIImage(named: "mendham2.jpeg")!, UIImage(named: "mendham3.jpeg")!, UIImage(named: "mendham4.jpeg")!, UIImage(named: "mendham5.jpeg")!]
            learnMoreURL = "https://itunes.apple.com/us/app/mendham-high-school/id910209781?mt=8"
            details = "I developed an app for my high school. Students can use it to see which class is next based on the rotating bell schedule, daily announcements, and more. You can also access the faculty directory and school calendar. \n Over 2/3 of students have the app installed on their iPhone, and there are hundreds of daily active users, especially helping incoming freshman adapt to a new schedule, school, and high school life!"
            theHeroImage = UIImage(named: "mendham4.jpeg")!
            movieName = "mendham"
        case "codebox":
            imageGallery = [UIImage(named: "codebox2.png")!, UIImage(named: "codebox.jpg")!]
            theHeroImage = UIImage(named: "codebox.jpg")!
            details = "At MHacks V, my team and I developed Codebox: an Objective-C interpretor for iOS. It uses NSInvocation to dynamically create real Objective-C classes at runtime and execute them on the iOS device. It also includes syntax highlighting, of course. It could be useful to experienced develoeprs who just want to prototype a cool new idea for an animation, all the way to beginners who just want to experiment like in Swift playgrounds, but on their iPhone or iPad (and in Objective-C)."
            learnMoreURL = "http://challengepost.com/software/codebox-8scr9"
            playButton.hidden = true
        case "calc":
            imageGallery = [UIImage(named: "calc.png")!, UIImage(named: "calc3.png")!, UIImage(named: "calc2.png")!]
            learnMoreURL = "https://github.com/harrisonw1/Calc"
            details = "Getting ready for Apple Watch, I realized ther was no built in calculator app which could be incredibly useful. So I mad myown. Calc. It's currently waiting for review for the App Store, and is open source too! On iPhone it's a beautiful calculator with the four main operators (+, -, x, ÷), and on Apple Watch, it fits the same functionality into a smaller display. Operators are displayed contextually with force touch to save space and make room for larger, still easy to press number buttons. It as a fun project to get started with Apple Watch programming and I hope others get to enjoy it or even learn from it's source!"
            theHeroImage = UIImage(named: "calc.png")!
            movieName = "calc"
            appTitle = "Calc"
        case "lake":
            details = "In July 2013, I was contracted by Lake and Wetland Management, a Florida based franchise with over 15 offices across the southeast US that specializes in maintaining and treating artificial lakes and wetland areas, to develop an iPad app for their field techs. Customer service is incredible important to Lake and Wetland, and the app allows field reports to be easily filed and accessed remotely, integrating with their customer database and the Aplicor 3C API. Customers get isntant email feedback on what services are done, and it makes it easier to account for all employee actions as well. Lake and Wetland Connect was built for internal use only and is not available on the App Store."
            learnMoreURL = "http://lakeandwetland.com"
            theHeroImage = UIImage(named: "lake.png")!
            imageGallery = [UIImage(named: "lake.png")!, UIImage(named: "lake2.png")!]
            playButton.hidden = true
        case "other":
            playButton.hidden = true
            learnMoreButton.hidden = true
            imageGallery = [UIImage(named: "pt.jpeg")!, UIImage(named: "ca.jpeg")!]
            details = "I began developing apps the summer of 2012, starting with Computer Acronyms: a simple reference app for common technology abbreviations. I later made Photo Tips which gave tips on photography. While the usability of these proejcts are long gone, it's fun to see how far I've come and how much those simple projects have inspired me to continue learning about programming and app development."
            theHeroImage = UIImage(named: "old.png")!
        default:
            println("incorrect shortname passed in")
            
        }
        
        //listen for done button pushed on the movie player and movie finish
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"doneButtonPushed:", name:MPMoviePlayerWillExitFullscreenNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "videoHasFinishedPlaying:",
            name: MPMoviePlayerPlaybackDidFinishNotification,
            object: nil)
        
        titleLabel.text = appTitle
        heroImage.image = theHeroImage
        detailsTextView.text = details
        
        animator = UIDynamicAnimator(referenceView: view)
    }

    override func viewDidAppear(animated: Bool) {
        //scroll up at launch to indicate scrollability
            detailsTextView.setContentOffset(CGPointZero, animated: true)
    }
    
    @IBAction func playVideo(sender: AnyObject) {
        
        //play video animation into
        UIView.animateWithDuration(0.15, delay: 0, options: nil, animations: { () -> Void in
            self.playButton.transform = CGAffineTransformMakeScale(0.85, 0.85)
            }, completion : nil)
        UIView.animateWithDuration(0.25, delay: 0.2, options: nil, animations: { () -> Void in
            self.playButton.transform = CGAffineTransformMakeScale(8, 8)
            }, completion: nil)
        
        let path = NSBundle.mainBundle().pathForResource(movieName, ofType:"mov")
        let url = NSURL.fileURLWithPath(path!)
        moviePlayer = MPMoviePlayerController(contentURL: url)
        
        moviePlayer!.view.frame = self.view.bounds
        moviePlayer!.prepareToPlay()
        moviePlayer!.scalingMode = .AspectFill
        
        delay(0.30){
            self.view.addSubview(self.moviePlayer!.view)
            self.moviePlayer!.setFullscreen(true, animated: true)
            self.moviePlayer?.play()
        }
        delay(0.4){
            self.playButton.transform = CGAffineTransformIdentity
        }

    }
    
    func endVideo() {
        moviePlayer?.stop()
        self.moviePlayer!.setFullscreen(false, animated: true)
        moviePlayer?.view.removeFromSuperview()
    }
    
    func doneButtonPushed(notification : NSNotification){
        endVideo()
    }
    
    func videoHasFinishedPlaying(notification : NSNotification){
        endVideo()
    }
    
    //cool way to easily access dispatch_async for delays like you'd do with Obj-C NSTimer
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    @IBAction func learnMore(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: learnMoreURL)!)
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
        let cell : PortfolioImageGalleryCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! PortfolioImageGalleryCollectionViewCell

        cell.imageView.image = imageGallery[indexPath.item]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            //set cells to fit nicely based on screen size
            return CGSize(width: self.view.frame.size.width * 0.75, height: 268)
            
    }
    
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! PortfolioImageGalleryCollectionViewCell
        //animations on touch down
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            cell.imageView.transform = CGAffineTransformMakeScale(0.7, 0.7)
        })
        
    }
    
    func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! PortfolioImageGalleryCollectionViewCell
        //animations on touch up
        UIView.animateWithDuration(0.15, animations: { () -> Void in
            cell.imageView.transform = CGAffineTransformMakeScale(1.2, 1.2)
        })
        
        UIView.animateWithDuration(0.15, delay: 0.15, options: nil, animations: { () -> Void in
            cell.imageView.transform = CGAffineTransformMakeScale(0.9, 0.9)
            }, completion: nil)
        UIView.animateWithDuration(0.08, delay: 0.3, options: nil, animations: { () -> Void in
            cell.imageView.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }, completion: nil)
        
    }
    
    
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //setup a blur and show the popover image detail view
        selectedImage = imageGallery[indexPath.row]

        createDetailBackground()
        setupImageDetailView()
        showTheImageDetailView()

    }
    
    func createDetailBackground() {
        //get a blurred view of the current screen context
        overlayView = UIView(frame: view.bounds)
        let imgView = UIImageView()
        imgView.frame = overlayView.frame
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0)
        view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
        
        var vFXBlur = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        vFXBlur.frame = imgView.bounds

        let img : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        imgView.image = img
        imgView.addSubview(vFXBlur)
        overlayView.addSubview(imgView)
        
        overlayView.alpha = 0.0
        view.addSubview(overlayView)
    }
    
    func setupImageDetailView() {
        //setup our frame
        let alertWidth: CGFloat = self.view.frame.size.width * 0.8
        let alertHeight: CGFloat = self.view.frame.size.height * 0.8
        
        let imageDetailViewFrame: CGRect = CGRectMake(0, 0, alertWidth, alertHeight)
        imageDetailView = UIView(frame: imageDetailViewFrame)
        imageDetailView.backgroundColor = UIColor.blackColor()
        imageDetailView.alpha = 0.0
        imageDetailView.layer.cornerRadius = 10;
        imageDetailView.layer.shadowColor = UIColor.blackColor().CGColor;
        imageDetailView.layer.shadowOffset = CGSizeMake(0, 5);
        imageDetailView.layer.shadowOpacity = 0.3;
        imageDetailView.layer.shadowRadius = 10.0;
        
        let button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.setTitle("Done", forState: UIControlState.Normal)
        button.backgroundColor = UIColor.blackColor()
        button.frame = CGRectMake(0, 0, alertWidth, 50.0)
        button.tintColor = UIColor.whiteColor()

        
        button.layer.borderColor = UIColor.whiteColor().CGColor
        button.layer.borderWidth = 0
        button.layer.cornerRadius = 5
        
        button.addTarget(self, action: Selector("dismissImageView"), forControlEvents: UIControlEvents.TouchUpInside)
        
        let theDetailImageView = UIImageView()
        theDetailImageView.frame = imageDetailView.frame
        theDetailImageView.image = selectedImage
        
        theDetailImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        imageDetailView.addSubview(theDetailImageView)
        imageDetailView.addSubview(button)

        view.addSubview(imageDetailView)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        //get the play button out of the way if the user scrolls to a certain point
        
        if scrollView.contentOffset.y >= 0.38 * heroImage.frame.size.height && playButtonTranslatedOffScreen == false {
            
            self.playButtonTranslatedOffScreen = true
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.playButton.transform = CGAffineTransformMakeTranslation(0, -200)
            })
        }
        else if scrollView.contentOffset.y < 0.38 * heroImage.frame.size.height && playButtonTranslatedOffScreen == true {
            
            self.playButtonTranslatedOffScreen = false
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.playButton.transform = CGAffineTransformMakeTranslation(0, 0)
            })
            
        }
        
    }
    
    func showTheImageDetailView() {

        if (imageDetailView == nil) {
            setupImageDetailView()
        }
        

        createGestureRecognizer()
        
        animator.removeAllBehaviors()
        
        // animate in the overlay
        UIView.animateWithDuration(0.4) {
            self.overlayView.alpha = 1.0
        }
        
        imageDetailView.alpha = 1.0
        
        var snapBehaviour: UISnapBehavior = UISnapBehavior(item: imageDetailView, snapToPoint: view.center)
        animator.addBehavior(snapBehaviour)
    }
    
    func dismissImageView() {
        //uikit dynamics swipe away like in tweetbot
        animator.removeAllBehaviors()
        
        var gravityBehaviour: UIGravityBehavior = UIGravityBehavior(items: [imageDetailView])
        gravityBehaviour.gravityDirection = CGVectorMake(0.0, 10.0);
        animator.addBehavior(gravityBehaviour)
        
        var itemBehaviour: UIDynamicItemBehavior = UIDynamicItemBehavior(items: [imageDetailView])
        itemBehaviour.addAngularVelocity(CGFloat(-M_PI_2), forItem: imageDetailView)
        animator.addBehavior(itemBehaviour)
        

        UIView.animateWithDuration(0.4, animations: {
            self.overlayView.alpha = 0.0
            }, completion: {
                (value: Bool) in
                self.imageDetailView.removeFromSuperview()
                self.imageDetailView = nil
        })
        
    }

    
    func createGestureRecognizer() {
        let panGestureRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("handlePan:"))
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    func handlePan(sender: UIPanGestureRecognizer) {
        
        if (imageDetailView != nil) {
            let panLocationInView = sender.locationInView(view)
            let panLocationInimageDetailView = sender.locationInView(imageDetailView)
            
            if sender.state == UIGestureRecognizerState.Began {
                animator.removeAllBehaviors()
                
                let offset = UIOffsetMake(panLocationInimageDetailView.x - CGRectGetMidX(imageDetailView.bounds), panLocationInimageDetailView.y - CGRectGetMidY(imageDetailView.bounds));
                attachmentBehavior = UIAttachmentBehavior(item: imageDetailView, offsetFromCenter: offset, attachedToAnchor: panLocationInView)
                
                animator.addBehavior(attachmentBehavior)
            }
            else if sender.state == UIGestureRecognizerState.Changed {
                attachmentBehavior.anchorPoint = panLocationInView
            }
            else if sender.state == UIGestureRecognizerState.Ended {
                animator.removeAllBehaviors()
                
                snapBehavior = UISnapBehavior(item: imageDetailView, snapToPoint: view.center)
                animator.addBehavior(snapBehavior)
                
                if sender.translationInView(view).y > 100 {
                    dismissImageView()
                }
            }
        }
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageGallery.count
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
