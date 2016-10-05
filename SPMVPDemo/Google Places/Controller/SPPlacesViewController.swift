//
//  SPPlacesViewController.swift
//  SPMVPDemo
//
//  Created by webonise on 03/10/16.
//  Copyright © 2016 webonise. All rights reserved.
//

import UIKit
import GooglePlaces

class SPPlacesViewController: UIViewController, SPPlacesPresenterDelegate
{
    let delegate = SPPlacesAutoCompleteDelegate()
    
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
  
    @IBOutlet weak var nameLabel    : UILabel!
    @IBOutlet weak var addressLabel : UILabel!
    
    
    // MARK: - ViewController delegate methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = "Current Place"
        
        self.setPresenter()
    }
    
    // MARK: End
    
    // MARK: - Local functions
    
    func setPresenter()
    {
        let presenter = SPPlacesPresenter.init(delegate: self)
        presenter.loadPlace()
    }
    
    func didSelectPlace(place: GMSPlace)
    {
        self.performSegueWithIdentifier("SPPlaceMapViewController", sender: place)
    }
    
    func updateCurrentLocationWith(placeName: NSString, address: NSString)
    {
        self.nameLabel.text     = placeName as String
        self.addressLabel.text  = address as String
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
    
    func openSearchAutoCompleteScreen()
    {
        let autocompleteController = GMSAutocompleteViewController()
        
        self.delegate.placesSearchController = self
        autocompleteController.delegate = self.delegate
        
        self.presentViewController(autocompleteController, animated: true, completion: nil)
    }
    
    // MARK: End
    
    // MARK:- SPPlacesPresenterDelegate methods
    
    func startLoadingPlace()
    {
        self.startActivityIndicator()
    }
    
    func finishLoadingPlace(place: GMSPlace)
    {
        self.stopActivityIndicator()
        
        self.updateCurrentLocationWith(place.name, address: place.formattedAddress!)
    }
    
    func failedLoadingPlace(message: NSString)
    {
        self.stopActivityIndicator()
        
        self.updateCurrentLocationWith("No current place", address: "")
    }
    
    // MARK: End

    // MARK: - Button Actions
    
    @IBAction func getCurrentPlace(sender: UIButton)
    {
        self.openSearchAutoCompleteScreen()
    }
    
    // MARK: End
    
    // MARK: - Memory
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: End
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "SPPlaceMapViewController"
        {
            let vc = segue.destinationViewController as! SPPlaceMapViewController
            vc.selectedPlace = sender as! GMSPlace
        }
    }
}
