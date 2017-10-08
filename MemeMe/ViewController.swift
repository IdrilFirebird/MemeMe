//
//  ViewController.swift
//  MemeMe
//
//  Created by Sebastian on 03.10.17.
//  Copyright © 2017 IdrilsBlog. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageViewBackground: UIImageView!
    @IBOutlet weak var imageView: MemeImageView!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var topText: UITextField!
    
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var topToolbar: UIToolbar!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraPickerButton: UIBarButtonItem!
    @IBOutlet weak var libraryPickerButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.insetsLayoutMarginsFromSafeArea  = true
        initButtons()
        
        initTextFields(textField: bottomText, defaultText: "BOTTOM", delegate: self)

        initTextFields(textField: topText, defaultText: "TOP" , delegate: self)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    //MARK: Helper Functions
    func blurImageView(imageViewToBlur: UIImageView) {
        imageViewToBlur.backgroundColor = UIColor.clear
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //always fill the view
        blurEffectView.frame = imageViewToBlur.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        imageViewToBlur.addSubview(blurEffectView)
    }

    func initTextFields(textField: UITextField, defaultText: String, delegate: UITextFieldDelegate) {
        let memeTextAttributes:[String:Any] = [
            
            NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
            NSAttributedStringKey.font.rawValue: UIFont(name: "Impact", size: 40)!,
            NSAttributedStringKey.strokeWidth.rawValue: -3.0]
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.text = defaultText
        textField.delegate = delegate
    }
    
    func initButtons() {
        cameraPickerButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        libraryPickerButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        
        shareButton.isEnabled = false
        cancelButton.isEnabled = false
    }
    
    func memeMefyImage() -> UIImage {
        UIGraphicsBeginImageContext(self.view.frame.size)
        
        hideToolBars(true)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        hideToolBars(false)
        return memedImage
    }
    
    func hideToolBars(_ hide: Bool)  {
        topToolbar.isHidden = hide
        bottomToolbar.isHidden = hide
    }
    
    func save(_ memedImage: UIImage?) {
        let meme: Meme
        if let memedImage = memedImage {
            meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imageView.image!, memedImage: memedImage)
        } else {
            meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imageView.image!, memedImage: memeMefyImage() )
        }
    }
    
    func presentImagePickerContoller(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    //MARK: Actions

    @IBAction func pickImageFromCamera(_ sender: Any) {
        presentImagePickerContoller(sourceType: .camera)
    }
    
    
    @IBAction func pickImageFromLibrary(_ sender: Any) {
        presentImagePickerContoller(sourceType: .photoLibrary)
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        let memedImage = memeMefyImage()
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityController.completionWithItemsHandler = {(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) -> Void in
            if completed == true {
                self.save(memedImage)
            }
        }
        
        
        present(activityController, animated: true, completion: nil)
    }
    
    //MARK: Keyboard handling
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomText.isFirstResponder {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if bottomText.isFirstResponder {
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide , object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
}


