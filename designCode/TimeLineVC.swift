//
//  TimeLineVC.swift
//  designCode
//
//  Created by KENNETH GRANDBERRY on 3/20/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit

class TimeLineVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Outlets
    @IBOutlet weak var tableView:UITableView!
    
    //Classes
    var customNavBtn = CustomNavBtns()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        let Menu = customNavBtn.CustomMenuBtn()
        Menu.addTarget(self.revealViewController(), action:Selector("revealToggle:"), forControlEvents: .TouchUpInside)
        
        //convert back to barbtn
        let leftBarBtn = UIBarButtonItem()
        leftBarBtn.customView = Menu
        self.navigationItem.rightBarButtonItem = leftBarBtn

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            return tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostCell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    

}
