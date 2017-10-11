//
//  ViewControllerDelegateExtensions.swift
//  MemeMe
//
//  Created by Sebastian on 08.10.17.
//  Copyright © 2017 IdrilsBlog. All rights reserved.
//

import UIKit

extension EditMemeViewController: UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            setImages(image)
        }
        self.shareButton.isEnabled = true
        dismiss(animated: true, completion: nil)
    }
}

extension EditMemeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
