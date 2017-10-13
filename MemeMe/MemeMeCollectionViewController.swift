//
//  MemeMeCollectionViewController.swift
//  MemeMe
//
//  Created by Sebastian on 11.10.17.
//  Copyright © 2017 IdrilsBlog. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MemeCell"

class MemeMeCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView?.reloadData()
        setFlowLayout()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        setFlowLayout()
    }



    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> MemeCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
        
        cell.memeCollectionCellImageView.image = appDelegate.memes[indexPath.row].memedImage
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let showImageViewController = storyboard?.instantiateViewController(withIdentifier: "ShowImageViewController") as! ShowImageViewController
        
        showImageViewController.meme = appDelegate.memes[indexPath.row]
        
        navigationController?.pushViewController(showImageViewController, animated: true)
    }

    func setFlowLayout() {
        let space:CGFloat = 3.0
        
        let numberOfCellsInRow : CGFloat = view.frame.size.height > view.frame.size.width ? 3.0 : 6.0
        
        let dimension = (view.frame.size.width - (numberOfCellsInRow - 1  * space)) / numberOfCellsInRow
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }

}
