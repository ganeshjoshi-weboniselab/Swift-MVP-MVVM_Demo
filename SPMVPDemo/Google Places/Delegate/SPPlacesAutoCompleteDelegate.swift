//
//  SPPlacesAutoCompleteDelegate.swift
//  SPMVPDemo
//
//  Created by webonise on 04/10/16.
//  Copyright © 2016 webonise. All rights reserved.
//

import UIKit
import GooglePlaces

class SPPlacesAutoCompleteDelegate: NSObject,GMSAutocompleteViewControllerDelegate
{
    var placesSearchController : SPPlacesViewController!
    
    // MARK: - GMSAutocompleteViewControllerDelegate methods
    
    // Handle the user's selection.
    func viewController(viewController: GMSAutocompleteViewController, didAutocompleteWithPlace place: GMSPlace)
    {
        self.placesSearchController.dismissViewControllerAnimated(true, completion: {self.placesSearchController.didSelectPlace(place)})
    }
    
    func viewController(viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: NSError)
    {
        
    }
    
    // User canceled the operation.
    func wasCancelled(viewController: GMSAutocompleteViewController)
    {
        self.placesSearchController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(viewController: GMSAutocompleteViewController)
    {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(viewController: GMSAutocompleteViewController)
    {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    // MARK: End
}
