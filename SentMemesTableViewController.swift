//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Curtis B Ford Jr on 9/28/15.
//  Copyright © 2015 Sona Software LLC. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    
    @IBAction func addMeme(sender: UIBarButtonItem) {
        performSegueWithIdentifier("editorSegue", sender: nil)
    }

    var rowTapped = 0
    
    var memes: [Meme]! {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    //make sure top row of table isn't under the navigation bar
    //see http://stackoverflow.com/questions/24468831/uitableview-goes-under-translucent-navigation-bar
    override func viewDidLayoutSubviews() {
        if let rect = self.navigationController?.navigationBar.frame {
            let y = rect.size.height + rect.origin.y
            self.tableView.contentInset = UIEdgeInsetsMake(y, 0, 0, 0)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationItem.hidesBackButton = true
        tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! SentMemesTableViewCell

        let theMeme = memes[indexPath.row]
        
        cell.thumbnail.image = theMeme.finishedMeme
        cell.label.text = theMeme.topText + " " + theMeme.bottomText

        return cell
    }
    
    
    // MARK: - Navigation
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        rowTapped = indexPath.row
        
        let detailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("displayMeme") as! SentMemesDisplayViewController
        detailViewController.displayView = self.memes[indexPath.row]
        self.navigationController!.pushViewController(detailViewController, animated: true)
        
    }
    
    //MARK: to display a meme
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "displayMemeSegue") {
        let detailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("displayMeme") as! SentMemesDisplayViewController
        detailViewController.displayView = self.memes[rowTapped]
        print("still in didSelectRow.. detailViewController.displayView is \(detailViewController.displayView)")
        self.navigationController!.pushViewController(detailViewController, animated: true)
        }
    }
    
    
    // MARK: to meme editor
    func makeNewMeme() {
        performSegueWithIdentifier("editorSegue", sender: self)
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // MARK: delete a meme
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            //Start by deleting the meme from the data source
            let theAppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            theAppDelegate.memes.removeAtIndex(indexPath.row)

            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    

    

}
