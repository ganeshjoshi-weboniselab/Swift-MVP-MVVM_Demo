//
//  ViewController.swift
//  SPMVPDemo
//
//  Created by webonise on 28/09/16.
//  Copyright © 2016 webonise. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SPUserInfoPresenterDelegate
{
    let userInfoDataSource = SPUserInfoTableViewDataSource()
    
    var arrayInvoicesModel : NSMutableArray = []
    
    @IBOutlet weak var tblUserInfoList : UITableView!
    
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    
    //#MARK:- ViewControllr delegate life cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.setPresenter()
    }
    
    //#MARK: End
    
    //#MARK:- Local functions
    
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