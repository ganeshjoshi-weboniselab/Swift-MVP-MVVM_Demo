//
//  SPPlacesPresenter.swift
//  SPMVPDemo
//
//  Created by webonise on 05/10/16.
//  Copyright © 2016 webonise. All rights reserved.
//

import UIKit
import GooglePlaces

protocol SPPlacesPresenterDelegate
{
    func startLoadingPlace()
    func finishLoadingPlace(place: GMSPlace)
    func failedLoadingPlace(message: NSString)
}

class SPPlacesPresenter: NSObject
{
    var delegate : SPPlacesPresenterDelegate!
    
    init(delegate: SPPlacesPresenterDelegate)
    {
        self.delegate = delegate
        
        super.init()        
    }

    func loadPlace()
    {
        GMSPlacesClient.sharedClient().currentPlaceWithCallback(
            {
                (placeLikelihoodList: GMSPlaceLikelihoodList?, error: NSError?) -> Void in
                
                self.delegate?.startLoadingPlace()
                
                if let error = error
                {
                    print("Pick Place error: \(error.localizedDescription)")
                    
                    self.delegate?.failedLoadingPlace(error.localizedDescription)
                    
                    return
                }
                else if let placeLikelihoodList = placeLikelihoodList
                {
                    if let place = placeLikelihoodList.likelihoods.first?.place
                    {
                        self.delegate?.finishLoadingPlace(place)
                    }
                    else
                    {
                        self.delegate?.failedLoadingPlace("Failed to fetch current place")
                    }
                }
        })
    }
}
