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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in viewDidLoad of SentMemesTableViewController")
        
//        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "makeNewMeme")
//        self.navigationItem.rightBarButtonItem = addButton
        
        //make sure back button doesn't show when returning from meme editor
        //self.navigationItem.hidesBackButton = true


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.hidesBackButton = true
        tableView.reloadData()
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
        return self.memes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! SentMemesTableViewCell

         //Configure the cell...
        //turn the meme object into an image
        let theMeme = memes[indexPath.row]
        
        cell.thumbnail.image = theMeme.finishedMeme
        cell.label.text = theMeme.topText + " " + theMeme.bottomText

        return cell
    }
    
    
    // MARK: - Navigation
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        rowTapped = indexPath.row
        print("rowTapped is \(rowTapped)")
        
//        let detailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("displayMeme") as! SentMemesDisplayViewController
//        detailViewController.displayView = self.memes[indexPath.row]
//        print("still in didSelectRow.. detailViewController.displayView is \(detailViewController.displayView)")
//        self.navigationController!.pushViewController(detailViewController, animated: true)
        
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
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        let selectedIndex = self.tableView.indexPathForCell(sender as! UITableViewCell)
//        // Get the new view controller using segue.destinationViewController.
//        if segue.identifier == "displaySegue" {
//            let detailViewController = segue.destinationViewController as! SentMemesDisplayViewController
//            //detailViewController.displayView = self.memes[selectedIndex] as! UIImage
//            detailViewController.displayView = self.memes[indexPath.row] as! UIImage
//
//            
//            }
    
        
        // Pass the selected object to the new view controller.
    //}
    
    // MARK: to meme editor
    func makeNewMeme() {
        performSegueWithIdentifier("editorSegue", sender: self)
    }


    // MARK: - Editing
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            //memes.removeAtIndex(indexPath.row)

            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            self.tableView.reloadData()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    

    

}
