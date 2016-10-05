//
//  SPPlaceMapPresenter.swift
//  SPMVPDemo
//
//  Created by webonise on 05/10/16.
//  Copyright © 2016 webonise. All rights reserved.
//

import UIKit
import GooglePlaces
import MapKit

protocol SPPlaceMapPresenterDelegate
{
    func placeAnnotation(placeAnnotation: MKPointAnnotation)
    
    func startLoadingPlacePhotos()
    func finishLoadingPlacePhotos(photos: NSArray)
    func failedLoadingPlacePhotos(message: NSString)
}

class SPPlaceMapPresenter: NSObject
{
    var delegate : SPPlaceMapPresenterDelegate!
    
    var place : GMSPlace
    
    init(place: GMSPlace, delegate: SPPlaceMapPresenterDelegate)
    {
        self.place = place
        self.delegate = delegate
        
        super.init()
        
        self.pinWithTitle(self.place.name, coordinate: self.place.coordinate)
    }
    
    /*
     * Returns region that fits in given map with center location & location of the given searched place
     */
    func getRegionWithCenterLocation(location: CLLocation, placeLocation: CLLocation, inMap : MKMapView)->MKCoordinateRegion?
    {
        var maxDistance : CLLocationDistance = 500;
        maxDistance = max(maxDistance, location.distanceFromLocation(placeLocation))
        
        var fittedRegion : MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, maxDistance * 2, maxDistance * 2)
        fittedRegion = inMap.regionThatFits(fittedRegion)
        fittedRegion.span.latitudeDelta *= 1.2;
        fittedRegion.span.longitudeDelta *= 1.2;
        
        return fittedRegion
    }
    
    /*
     * Create annotation pin to show on map with given title & coordinates
     */
    func pinWithTitle(title: NSString, coordinate: CLLocationCoordinate2D)
    {
        let placeAnnotation = MKPointAnnotation()
        
        placeAnnotation.title = title as String
        placeAnnotation.coordinate = coordinate
        
        self.delegate?.placeAnnotation(placeAnnotation)
        
        self.loadPlacePhotos()
    }
    
    func loadPlacePhotos()
    {
        self.delegate?.startLoadingPlacePhotos()
        
        GMSPlacesClient.sharedClient().lookUpPhotosForPlaceID(self.place.placeID)
        { (photos, error) -> Void in
            
            if let error = error
            {
                print("Error: \(error.description)")
                
                self.delegate?.failedLoadingPlacePhotos(error.description)
            }
            else
            {
                self.fecthPlacePhotosFromPhotosMetaData((photos?.results)!)
            }
        }
    }
    
    /*
     * Fetches photos from GMSPlacePhotoMetadata list
     */
    func fecthPlacePhotosFromPhotosMetaData(photos : NSArray)
    {
        self.delegate?.startLoadingPlacePhotos()
        
        let photoList = NSMutableArray()
        
        let count = photos.count
        
        var photoCount = 0
        
        for i in 0 ..< count
        {
            GMSPlacesClient.sharedClient().loadPlacePhoto(photos.objectAtIndex(i) as! GMSPlacePhotoMetadata, callback:
                { (photo, error) in
                    
                    if let error = error
                    {
                        print("Error: \(error.description)")
                    }
                    else
                    {
                        photoList.addObject(photo!)
                        
                        photoCount = photoCount + 1;
                        
                        if (photoCount == photos.count)
                        {
                            self.fifnishedFetchiongPhotos(photoList)
                        }
                    }
            })
        }
    
        
    }
    
    func fifnishedFetchiongPhotos(photos : NSArray)
    {
        if photos.count > 0
        {
            self.delegate?.finishLoadingPlacePhotos(photos)
        }
        else
        {
            self.delegate?.failedLoadingPlacePhotos("Failed to load photos")
        }
    }
}
