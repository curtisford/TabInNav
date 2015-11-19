//
//  SentMemesDisplayViewController.swift
//  MemeMe
//
//  Created by Curtis Ford on 11/16/15.
//  Copyright © 2015 Sona Software LLC. All rights reserved.
//

import UIKit

class SentMemesDisplayViewController: UIViewController {

    var displayView: Meme!
    
    @IBOutlet weak var memedImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        print("starting viewWillAppear; var displayView is \(displayView)")
        memedImage.image = displayView.finishedMeme

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
