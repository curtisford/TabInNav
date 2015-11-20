//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Curtis B Ford Jr on 9/28/15.
//  Copyright © 2015 Sona Software LLC. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "sentMemeCell"

class SentMemesCollectionViewController: UICollectionViewController {

    var memes: [Meme]! {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
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
        print("in viewDidLoad of SentMemesCollectionViewController")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "makeNewMeme:")
        self.navigationItem.rightBarButtonItem = addButton

        // Register cell classes
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        collectionView?.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("starting didSelectItemAtIndexPath...")
        cellTapped = indexPath.item
        print("cellTapped is \(cellTapped)")
        
        let detailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("displayMeme") as! SentMemesDisplayViewController
        detailViewController.displayView = self.memes[indexPath.row]
        print("still in didSelectItemAtIndexPath.. detailViewController.displayView is \(detailViewController.displayView)")
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
//    // MARK: navigate to meme editor
//    func makeNewMeme() {
//        print("starting makeNewMeme")
//        performSegueWithIdentifier("editMeme", sender: self)
//    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        if (segue.identifier == "displayMemeSegue") {
            let detailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("displayMeme") as! SentMemesDisplayViewController
            detailViewController.displayView = self.memes[cellTapped]
            print("still in prepareForSegue.. detailViewController.displayView is \(detailViewController.displayView)")
            self.navigationController!.pushViewController(detailViewController, animated: true)
        }
        // Pass the selected object to the new view controller.
    }
    
    /*PASTED IN FROM TABLEVIEWCONTROLLER
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "displayMemeSegue") {
            let detailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("displayMeme") as! SentMemesDisplayViewController
            detailViewController.displayView = self.memes[rowTapped]
            print("still in didSelectRow.. detailViewController.displayView is \(detailViewController.displayView)")
            self.navigationController!.pushViewController(detailViewController, animated: true)
        }
    }
*/
    

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
