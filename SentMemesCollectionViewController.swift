//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Curtis B Ford Jr on 9/28/15.
//  Copyright © 2015 Sona Software LLC. All rights reserved.
//

import UIKit


class SentMemesCollectionViewController: UICollectionViewController {

    var memes: [Meme]! {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    //used in didSelectItem... and prepareForSegue
    var cellTapped = 0
    
    //make sure top row of table isn't under the navigation bar
    //see http://stackoverflow.com/questions/24468831/uitableview-goes-under-translucent-navigation-bar
    override func viewDidLayoutSubviews() {
        if let rect = self.navigationController?.navigationBar.frame {
            let y = rect.size.height + rect.origin.y
            self.collectionView!.contentInset = UIEdgeInsetsMake(y, 0, 0, 0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func viewWillAppear(animated: Bool) {
        collectionView?.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK: - Navigation
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        cellTapped = indexPath.item
        
        let detailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("displayMeme") as! SentMemesDisplayViewController
        detailViewController.displayView = self.memes[indexPath.row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }

    //preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "displayMemeSegue") {
            let detailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("displayMeme") as! SentMemesDisplayViewController
            detailViewController.displayView = self.memes[cellTapped]
            self.navigationController!.pushViewController(detailViewController, animated: true)
        }
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> SentMemesCollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("sentMemeCell", forIndexPath: indexPath) as! SentMemesCollectionViewCell
    
        // Configure the cell
        let theMeme = memes[indexPath.row]
        
        cell.thumbnail.image = theMeme.finishedMeme
    
        return cell
    }
    


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
