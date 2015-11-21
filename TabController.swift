//
//  TabController.swift
//  TabInNav
//
//  Created by Curtis Ford on 11/18/15.
//  Copyright © 2015 Sona Software LLC. All rights reserved.
//

import UIKit

class TabController: UITabBarController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    // MARK: - Navigation
    
    @IBAction func cancelToTabBar(segue:UIStoryboardSegue) {
        //this allows the unwind segue to jump back here from the meme editor
    
    }

    

}
