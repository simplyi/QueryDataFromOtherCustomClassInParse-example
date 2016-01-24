//
//  MusicTableViewController.swift
//  ParseOneToManyRelationship
//
//  Created by Sergey Kargopolov on 2016-01-23.
//  Copyright © 2016 Sergey Kargopolov. All rights reserved.
//

import UIKit
import Parse

class MusicTableViewController: UITableViewController {

    @IBOutlet var myTable: UITableView!
    
    var selectedUser:PFUser?
    var userMusicItems = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        loadUserMusic(selectedUser!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return userMusicItems.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let musicCell = tableView.dequeueReusableCellWithIdentifier("musicCell", forIndexPath: indexPath)
        
        let musicItem = userMusicItems[indexPath.row]
        let musicSongTitle = musicItem.objectForKey("song_title") as? String
        
        musicCell.textLabel?.text = musicSongTitle
        
        return musicCell
    }
    
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
     let musicItem = userMusicItems[indexPath.row]
   
     print("Song title = \(musicItem.objectForKey("song_title")! )")
     print("Artist name = \(musicItem.objectForKey("artist_name")! )")
    
     let musicOwnerObject:PFUser = musicItem.objectForKey("User") as! PFUser
    
     print("Music item owner \(musicOwnerObject.username!)")
     print("Music item owner \(musicOwnerObject.objectId!)")
     print("Music item owner \(musicOwnerObject.objectForKey("email")! )")

    }
    
    
    func loadUserMusic(selectedUser: PFUser)
    {
        
        let musicQuery = PFQuery(className: "Music")
        musicQuery.whereKey("User", equalTo: selectedUser)
        musicQuery.includeKey("User")
        
        musicQuery.findObjectsInBackgroundWithBlock { (result:[PFObject]?, error:NSError?) -> Void in
            
            if let searchResults = result
            {
               print("Found records: \(searchResults.count) ")
                
                self.userMusicItems = searchResults
                self.myTable.reloadData()
            }
            
        }
        
    }

     
}
