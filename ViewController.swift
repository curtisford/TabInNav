//
//  ViewController.swift
//  TextFieldsTryout
//
//  Created by Curtis Ford on 8/15/15.
//  Copyright (c) 2015 Sona Software LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var topField: UITextField!
    @IBOutlet weak var bottomField: UITextField!
    @IBOutlet weak var theImage: UIImageView!
    
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var selectFromAlbum: UIBarButtonItem!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelMeme: UIBarButtonItem!
    
    var memes: [Meme]!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("in viewDidLoad of ViewController.swift; presenting viewcontroller is \(self.presentingViewController)")
        
        shareButton.enabled = false
        
        let memeTextAttributes = [
            
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -3.0
        ]
        
        topField.defaultTextAttributes = memeTextAttributes
        bottomField.defaultTextAttributes = memeTextAttributes
        topField.textAlignment = .Center
        bottomField.textAlignment = .Center
        
        bottomField.delegate = self
        topField.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewDidAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }
    
    // MARK: Save meme
    func save() {
        //create the meme
        let meme = Meme(topText: topField.text!, bottomText: bottomField.text!, image: theImage.image!, finishedMeme: generateMemedImage())
        
        //add it to the memes array
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
    
    // MARK: Share meme
    @IBAction func shareTheMeme(sender: UIBarButtonItem) {
        
        let textToShare = "Feast your eyes on this wondrous meme!"
        
        let meme = generateMemedImage()
        
        let objectsToShare = [textToShare, meme]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        //don't include these
        activityVC.excludedActivityTypes = [UIActivityTypeAirDrop,
            UIActivityTypeAddToReadingList,
            UIActivityTypeAssignToContact,
            UIActivityTypePostToFlickr,
            UIActivityTypePostToVimeo]
        
        presentViewController(activityVC, animated: true, completion: nil)
        
        activityVC.completionWithItemsHandler = {
            (activity: String?, completed: Bool, items: [AnyObject]?, error: NSError?) -> Void in
            if completed {
                
                self.save()
                
                self.performSegueWithIdentifier("unwindToTabController", sender: self)
                
            }
        }
    }
    
    func generateMemedImage() -> UIImage {
        
        toolBar.hidden = true
        
        //render to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let finishedMeme:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        toolBar.hidden = false
        
        return finishedMeme
    }
    
    
    @IBAction func cancelMeme(sender: UIBarButtonItem) {
        
        print("starting cancelMeme")
        //dismiss keyboard before calling alert to fix font issue
        bottomField.resignFirstResponder()
        topField.resignFirstResponder()
        
                let alertView = UIAlertController(title: "Cancel meme", message: "Are you sure you don't want to keep this meme?", preferredStyle: .Alert)
                alertView.addAction(UIAlertAction(title: "Delete meme", style: .Default, handler: { (alertAction) -> Void in
                    self.throwMemeAway()
                }))
                alertView.addAction(UIAlertAction(title: "Keep meme", style: .Cancel, handler: nil))
                presentViewController(alertView, animated: true, completion: nil)
        
        //go back to where you came from
        print("presentingViewController is \(presentingViewController)")
        //oops - presentingViewController may be nil if you're coming from a button in a tabbarcontroller
        //presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        self.performSegueWithIdentifier("unwindToTabController", sender: self)

        
    }
    
    func throwMemeAway() {
        theImage.image = nil
        topField.text = "ENTER TEXT HERE"
        bottomField.text = "MAKE IT FUNNY"
    }
    
    
    
    // MARK: Select from album
    @IBAction func selectFromAlbum(sender: UIBarButtonItem) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(pickerController, animated: true, completion: nil)
    }
    
    //MARK: Take a picture
    @IBAction func takeAPicture(sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            theImage.image = image
            shareButton.enabled = true
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Keyboard management
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func keyboardWillShow(notification:NSNotification) {
        //checking bottomField for first responder keeps view from moving when top field is tapped
        if bottomField.isFirstResponder() {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification:NSNotification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(notification:NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
}

