//
//  ShowImageViewController.swift
//  MemeMe
//
//  Created by Sebastian on 11.10.17.
//  Copyright © 2017 IdrilsBlog. All rights reserved.
//

import UIKit

class ShowImageViewController: UIViewController, EditMemeViewControllerDelegate {


    var meme : Meme!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = meme.memedImage
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(ShowImageViewController.showEditView))
    }

    
    @objc func showEditView() {
        let editMemeViewController = storyboard!.instantiateViewController(withIdentifier: "EditMemeViewController") as! EditMemeViewController
        
        editMemeViewController.meme = meme
        editMemeViewController.delegate = self
        
        present(editMemeViewController, animated: true, completion: nil)
        
    }


    func editMemeViewControllerDidExit() {
        navigationController?.popToRootViewController(animated: true);
    }
    
    
}
