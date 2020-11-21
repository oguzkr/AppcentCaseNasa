//
//  ViewController.swift
//  AppcentCaseNasa
//
//  Created by Oğuz Karatoruk on 19.11.2020.
//

import UIKit
import Alamofire
import SDWebImage
import SwiftGifOrigin

class ViewController: UIViewController {
    
    var currentPage = 1
    var currentTab = 1
    var network: networkManager = networkManager()
    var rovers = [Photos]()
    
    @IBOutlet weak var segmentedView: tabBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let margin: CGFloat = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        setSegmented()
        clickCuriosity()
        collectionView.dataSource = self
        collectionView.delegate = self
        guard let collectionView = collectionView, let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
           flowLayout.minimumInteritemSpacing = margin
           flowLayout.minimumLineSpacing = margin
           flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        
        network.getRoverData(tab: 1, page: 1) {
            self.rovers = self.network.rovers
            self.collectionView.reloadData()
        }
    }
    
  
    
    func setSegmented(){
        segmentedView.currentTab = currentTab
        segmentedView.buttonSegmented1.addTarget(self, action: #selector(clickCuriosity), for: .touchUpInside)
        segmentedView.buttonSegmented2.addTarget(self, action: #selector(clickOpportunity), for: .touchUpInside)
        segmentedView.buttonSegmented3.addTarget(self, action: #selector(clickSprit), for: .touchUpInside)
        segmentedView.layoutSubviews()
    }
    
    @objc func clickCuriosity() {
        segmentedView.clickSegment1(animated: true)
        currentTab = segmentedView.currentTab
        getRoverData()
        UIView.animate(withDuration: 0.2) {
            self.view.layoutSubviews()
        }
    }
    
    @objc func clickOpportunity() {
        segmentedView.clickSegment2(animated: true)
        currentTab = segmentedView.currentTab
        getRoverData()
        UIView.animate(withDuration: 0.2) {
            self.view.layoutSubviews()
        }
        
    }
    
    @objc func clickSprit() {
        segmentedView.clickSegment3(animated: true)
        currentTab = segmentedView.currentTab
        getRoverData()
        UIView.animate(withDuration: 0.2) {
            self.view.layoutSubviews()
        }
    }
    
    func getRoverData(){
        network.getRoverData(tab: currentTab, page: currentPage, completed: {
            self.rovers = self.network.rovers
            self.collectionView.reloadData()
        })
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rovers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier: String = "cell"
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath as IndexPath)

        cell.layer.cornerRadius = 10
        
        cell.clipsToBounds = true
        let image : UIImageView = cell.contentView.viewWithTag(1) as! UIImageView
        
        let url = URL(string: "\(rovers[indexPath.row].imgSrc)")
        image.sd_setImage(with: url, placeholderImage: UIImage.gif(asset: "load.gif"))
        
        return cell

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: 200)
    }
}
