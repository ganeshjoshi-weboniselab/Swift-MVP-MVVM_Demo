//
//  ViewController.swift
//  SPMVPDemo
//
//  Created by webonise on 28/09/16.
//  Copyright © 2016 webonise. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, SPUserInfoPresenterDelegate, LocationServiceDelegate
{
    let userInfoDataSource = SPUserInfoTableViewDataSource()
    
    var arrayInvoicesModel : NSMutableArray = []
    
    var location : GPSLocationHandler!
    
    @IBOutlet weak var tblUserInfoList : UITableView!
    
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    
    //#MARK:- ViewControllr delegate life cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.startGPS()
        
        self.setPresenter()
        
        self.addPlacesItemButton()
    }
    
    //#MARK: End
    
    //#MARK:- Local functions
    
    func startGPS()
    {
        location = GPSLocationHandler.sharedInstance
        location.delegate = self
        location.startUpdatingLocation()
    }
    
    func addPlacesItemButton()
    {
        let places = UIBarButtonItem.init(title: "Places", style: UIBarButtonItemStyle.Plain, target: self, action:  #selector(ViewController.openPlaces))
        self.navigationItem.rightBarButtonItem = places
    }
    
    func openPlaces()
    {
        self.performSegueWithIdentifier("SPPlacesViewController", sender: self)
    }
    
    func configureView(userInfoList : NSArray)
    {
        userInfoDataSource.userInfoList = userInfoList
        
        self.tblUserInfoList.dataSource = userInfoDataSource
        self.tblUserInfoList.delegate = userInfoDataSource
        
        self.updateUserInfoList()
    }
    
    func updateUserInfoList()
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.tblUserInfoList.reloadData()
        })
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
    
    func setPresenter()
    {
        let presenter = SPUserInfoPresenter()
        
        presenter.delegate = self;
        presenter.getUserInfoListFromServer()
    }
    
    //#MARK: End
    
    //#MARK:- Presenter delegate methods
    
    func startLoadingUserInfoFromServer()
    {
        self.startActivityIndicator()
    }
    
    func finishLoadingUserInfoList(userInfoList: NSArray)
    {
        self.stopActivityIndicator()
        
        self.configureView(userInfoList)
    }
    
    func failedLoadingUserInfoListWithMessage(message: NSString)
    {
        self.stopActivityIndicator()
        
        self.alert(message as String, title: "")
    }
    
    //#MARK: End

    //#MARK:- Memory
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //#MARK: End
    
    //#MARK:- GPSLocationHandlerDelegate
    
    func tracingLocation(currentLocation: CLLocation)
    {
        
    }
    
    func tracingLocationDidFailWithError(error: NSError)
    {
        
    }
    
    //#MARK: End
}

/*
extension ViewController
{
    func alertWithMessage(message: String, title: String = "")
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}
 */