//
//  SPPlaceMapViewController.swift
//  SPMVPDemo
//
//  Created by webonise on 04/10/16.
//  Copyright © 2016 webonise. All rights reserved.
//

import UIKit
import GooglePlaces
import MapKit

let TOP_MARGIN      : CGFloat = 8
let LEFT_MARGIN     : CGFloat = 10
let PHOTO_WIDTH     : CGFloat = 112
let PHOTO_HEIGHT    : CGFloat = 112

class SPPlaceMapViewController: UIViewController, SPPlaceMapPresenterDelegate
{
    var selectedPlace : GMSPlace!
    
    var mapPresenter : SPPlaceMapPresenter!
    
    @IBOutlet weak var mapView              : MKMapView!
    @IBOutlet weak var scrollView           : UIScrollView?
    
    @IBOutlet weak var activityIndicator    : UIActivityIndicatorView!
    
    //MARK:- ViewController delegate methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = self.selectedPlace.name
        
        self.startActivityIndicator()
        
        self.performSelector(#selector(setPresenter), withObject: self, afterDelay: 1.0)
    }

    //MARK: End
    
    //MARK:- Local functions
    
    func setPresenter()
    {
        self.mapPresenter = SPPlaceMapPresenter.init(place: self.selectedPlace, delegate: self)
        self.mapPresenter.loadPlacePhotos()
    }
    
    func startActivityIndicator()
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.view.userInteractionEnabled = false;
            self.activityIndicator.startAnimating()
        })
    }
    
    func stopActivityIndicator()
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.view.userInteractionEnabled = true;
            self.activityIndicator.stopAnimating()
        })
    }
    
    func loadPhotosInScrollView(photos:NSArray)
    {
        var x : CGFloat = 0
        
        for i in 0 ..< photos.count
        {
            let btn = Utility.getButtonWithFrame(CGRectMake(x + LEFT_MARGIN, TOP_MARGIN, PHOTO_WIDTH, PHOTO_HEIGHT), buttonTag: i, image: photos.objectAtIndex(i) as! UIImage)
            btn!.addTarget(self, action: #selector(didSelectPhoto), forControlEvents: UIControlEvents.TouchUpInside)
            self.scrollView?.addSubview(btn!)
            
            x = x + LEFT_MARGIN + PHOTO_WIDTH
        }
        
        self.scrollView?.contentSize = CGSizeMake(x+LEFT_MARGIN, (self.scrollView?.frame.size.height)!)
    }
    
    func didSelectPhoto(sender : UIButton)
    {
        
    }
    
    func fitAnnotationKeepingInCenter()
    {
        let centerLocation = CLLocation.init(latitude: self.mapView.centerCoordinate.latitude, longitude: self.mapView.centerCoordinate.longitude)
        let placeLocation = CLLocation.init(latitude: self.selectedPlace.coordinate.latitude, longitude: self.selectedPlace.coordinate.longitude)
        
        self.mapView.setRegion(self.mapPresenter.getRegionWithCenterLocation(centerLocation, placeLocation: placeLocation, inMap: self.mapView)!, animated:true)
    }
    
    //MARK: End
    
    //MARK:- SPPlaceMapPresenterDelegate methods
    
    func placeAnnotation(placeAnnotation: MKPointAnnotation)
    {
        self.mapView.addAnnotation(placeAnnotation)
    }
    
    func startLoadingPlacePhotos()
    {
        self.startActivityIndicator()
    }
    
    func finishLoadingPlacePhotos(photos: NSArray)
    {
        self.fitAnnotationKeepingInCenter()
        
        self.stopActivityIndicator()
        
        self.loadPhotosInScrollView(photos)
    }
    
    func failedLoadingPlacePhotos(message: NSString)
    {
        self.stopActivityIndicator()
    }
    
    //MARK: End
    
    //MARK:- Memory
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: End

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension ViewController
{
    func alert(message: String, title: String = "")
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}
