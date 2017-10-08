//
//  ViewControllerDelegateExtensions.swift
//  MemeMe
//
//  Created by Sebastian on 08.10.17.
//  Copyright © 2017 IdrilsBlog. All rights reserved.
//

import UIKit

extension ViewController: UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
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
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
