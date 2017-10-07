//
//  ViewController.swift
//  MemeMe
//
//  Created by Sebastian on 03.10.17.
//  Copyright © 2017 IdrilsBlog. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate {

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
    
    
    let memeTextAttributes:[String:Any] = [
    
    NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "Impact", size: 40)!,
        NSAttributedStringKey.strokeWidth.rawValue: -3.0,]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.insetsLayoutMarginsFromSafeArea  = true
        cameraPickerButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        libraryPickerButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        shareButton.isEnabled = false
        cancelButton.isEnabled = false
        
        bottomText.defaultTextAttributes = memeTextAttributes
        bottomText.text = "BOTTOM"
        bottomText.delegate = self
        
        topText.defaultTextAttributes = memeTextAttributes
        topText.text = "TOP"
        topText.delegate = self
        
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
    
  
    
    
    //MARK: Actions

    @IBAction func pickImageFromCamera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func pickImageFromLibrary(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        let memedImage = memeMefyImage()
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        present(activityController, animated: true, completion: {self.save(memedImage)})
    }
    
    
    //MARK: Delegate Methods
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.image = image
            // Add second Image View in the background with blur
            self.imageViewBackground.image = image
            blurImageView(imageViewToBlur: self.imageViewBackground)
        }
        self.shareButton.isEnabled = true
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: Keyboard handling
    @objc func keyboardWillShow(_ notification:Notification) {
        
        view.frame.origin.y = 0 - getKeyboardHeight(notification)
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
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

