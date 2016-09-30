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
    
    @IBOutlet weak var tblUserInfoList: UITableView!
    
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
    
    //#MARK: End
    
    //#MARK:- ViewControllr delegate life cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let presenter = SPUserInfoPresenter()
        presenter.delegate = self;
        presenter.getUserInfoListFromServer()
    }
    
    //#MARK: End
    
    //#MARK:-
    
    func finishLoadingUserInfoList(userInfoList: NSArray)
    {
        self.configureView(userInfoList)
    }
    
    func failedLoadingUserInfoListWithMessage(message: NSString)
    {
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