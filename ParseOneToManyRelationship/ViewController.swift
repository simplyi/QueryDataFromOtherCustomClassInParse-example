//
//  ViewController.swift
//  ParseOneToManyRelationship
//
//  Created by Sergey Kargopolov on 2016-01-23.
//  Copyright © 2016 Sergey Kargopolov. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTable: UITableView!
    
    var users = [PFUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return users.count
    }
 
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let userCell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath)
        
        let userObject:PFUser = users[indexPath.row]
        
        userCell.textLabel!.text = userObject.objectForKey("first_name") as? String
        
        return userCell
    }
    
   func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
   {

     let selectedUser:PFUser = users[indexPath.row]
    
     let musicTableViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MusicTableViewController") as! MusicTableViewController
    
      musicTableViewController.selectedUser = selectedUser
    
    
    self.navigationController?.pushViewController(musicTableViewController, animated: true)
 
   }

    func loadUsers()
    {
        let userQuery = PFQuery(className: "_User")
        userQuery.findObjectsInBackgroundWithBlock { (result:[PFObject]?, error: NSError?) -> Void in
            
            if let foundUsers = result as? [PFUser]
            {
                self.users = foundUsers
                self.myTable.reloadData()
            }
        
        }
        
    }

}

