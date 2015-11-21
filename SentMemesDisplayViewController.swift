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
        
        memedImage.image = displayView.finishedMeme
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        memedImage.image = displayView.finishedMeme

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
