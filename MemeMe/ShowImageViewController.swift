//
//  ShowImageViewController.swift
//  MemeMe
//
//  Created by Sebastian on 11.10.17.
//  Copyright © 2017 IdrilsBlog. All rights reserved.
//

import UIKit

class ShowImageViewController: UIViewController {

    var meme : Meme!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = meme.memedImage
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(ShowImageViewController.showEditView))
        // Do any additional setup after loading the view.
    }

    
    @objc func showEditView() {
        let editMemeViewController = storyboard!.instantiateViewController(withIdentifier: "EditMemeViewController") as! EditMemeViewController
        
        editMemeViewController.meme = meme
        
        present(editMemeViewController, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
