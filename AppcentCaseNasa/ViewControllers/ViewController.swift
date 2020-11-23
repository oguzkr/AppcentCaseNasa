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
import SVProgressHUD

class ViewController: UIViewController {
    
    var currentPage = 1
    var currentTab = 1
    var network: networkManager = networkManager()
    var rovers = [Photos]()
    var scrollcontrol = true
    var cameraFilterOptions = Array<String>()
    let margin: CGFloat = 10
    
    //VARIABLES FOR POPUP SCREEN
    var imgURL = String()
    var imgDate = String()
    var imgRoverName = String()
    var imgCameraName = String()
    var imgRoverStatus = String()
    var imgLandingDate = String()
    var imgLaunchDate = String()
    
    @IBOutlet weak var segmentedView: tabBar!
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setSegmented()
        clickCuriosity()
        setCollectioView()
        network.getRoverData(tab: 1, page: 1) {
            self.rovers = self.network.rovers
            self.collectionView.reloadData()
            self.getCameraFilterOptions()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.filterData(notification:)), name: NSNotification.Name(rawValue: "filter"), object: nil)
    }
    
    @IBAction func clickShowFilter(_ sender: Any) {
        showFilterOptions(options: self.cameraFilterOptions)
    }
    
    //MARK: TABBAR BUTTONS
    @objc func clickCuriosity() {
        segmentedView.clickSegment1(animated: true)
        currentTab = segmentedView.currentTab
        currentPage = 1
        getRoverData()
        UIView.animate(withDuration: 0.2) {
            self.view.layoutSubviews()
        }
    }
    
    @objc func clickOpportunity() {
        segmentedView.clickSegment2(animated: true)
        currentTab = segmentedView.currentTab
        currentPage = 1
        getRoverData()
        UIView.animate(withDuration: 0.2) {
            self.view.layoutSubviews()
        }
    }
    
    @objc func clickSprit() {
        segmentedView.clickSegment3(animated: true)
        currentTab = segmentedView.currentTab
        currentPage = 1
        getRoverData()
        UIView.animate(withDuration: 0.2) {
            self.view.layoutSubviews()
        }
    }
    
    //MARK:FILTER FUNCTIONS
    func getCameraFilterOptions(){
        if currentPage == 1 {
            cameraFilterOptions.removeAll()
            cameraFilterOptions.append("ALL")
        }
        for rover in self.network.rovers {
            if cameraFilterOptions.contains(rover.camera.name) {
                //don't append
            } else {
                cameraFilterOptions.append(rover.camera.name)
            }
        }
        print("FILTER OPTIONS: \(cameraFilterOptions)")
    }
    
    func getFilteredRoverData(camera:String){
        self.rovers.removeAll()
        if currentPage == 1 {
            network.getRoverData(tab: currentTab, page: currentPage) {
                for rover in self.network.rovers {
                    print(rover)
                    if rover.camera.name.contains(camera) {
                        self.rovers.append(rover)
                    }
                }
                self.collectionView.reloadData()
            }
        } else {
            for page in 1...currentPage {
                print("Page \(page)")
                network.getRoverData(tab: currentTab, page: page) {
                    for rover in self.network.rovers {
                        print(rover)
                        if rover.camera.name.contains(camera) {
                            self.rovers.append(rover)
                        }
                    }
                    self.collectionView.reloadData()
                }
            }
        }
        getCameraFilterOptions()
    }
    
    @objc func filterData(notification: NSNotification) {
        if let selectedFilter = notification.userInfo?["selectedFilter"] as? String {
            if selectedFilter == "ALL" {
                getRoverData()
            } else {
                getFilteredRoverData(camera: selectedFilter)
            }
            print(selectedFilter)
        }
     }
    
    //MARK: collectionView and tabBar customizations
    func setCollectioView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        guard let collectionView = collectionView, let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
           flowLayout.minimumInteritemSpacing = margin
           flowLayout.minimumLineSpacing = margin
           flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
    
    func setSegmented(){
        segmentedView.currentTab = currentTab
        segmentedView.buttonSegmented1.addTarget(self, action: #selector(clickCuriosity), for: .touchUpInside)
        segmentedView.buttonSegmented2.addTarget(self, action: #selector(clickOpportunity), for: .touchUpInside)
        segmentedView.buttonSegmented3.addTarget(self, action: #selector(clickSprit), for: .touchUpInside)
        segmentedView.layoutSubviews()
    }
    
    //MARK: GET & INSERT DATA
    func getRoverData(){
        if currentPage == 1 {
            network.getRoverData(tab: currentTab, page: currentPage, completed: {
                self.rovers = self.network.rovers
                self.collectionView.reloadData()
                self.getCameraFilterOptions()
                self.collectionView.setContentOffset(.zero, animated: false)
            })
        } else {
            self.rovers.removeAll()
            for page in 1...currentPage {
                network.getRoverData(tab: currentTab, page: page, completed: {
                    self.rovers += self.network.rovers
                    self.collectionView.reloadData()
                    self.getCameraFilterOptions()
                    self.collectionView.setContentOffset(.zero, animated: false)
                })
            }
        }
    }
    
    func insertNextPage(){
        currentPage += 1
        network.getRoverData(tab: currentTab, page: currentPage, completed: {
            self.rovers += self.network.rovers
            self.collectionView.reloadData()
            self.getCameraFilterOptions()
            self.scrollcontrol = true
        })
    }
    
    
    //MARK: SHOW POPUP VIEWS
    func showFilterOptions(options: Array<String>){
        let popCV = self.storyboard?.instantiateViewController(withIdentifier: "FilterOptionsViewController") as! FilterOptionsViewController
        popCV.cameraFilterOptions = options
        popCV.view.frame.origin.y = self.view.frame.height
        popCV.view.backgroundColor = UIColor.clear
        UIView.animate(withDuration: 0.20, animations: {
            self.addChild(popCV)
            popCV.view.frame = self.view.frame
            self.view.addSubview(popCV.view)
            popCV.didMove(toParent: self)
        }) { (nil) in
            popCV.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
    }
    
    func showRoverInfo(roverImgURL:String, roverImgDate:String, roverImgRoverName:String, roverImgCameraName:String,roverImgRoverStatus:String, roverImgLandingDate:String, roverImgLaunchDate:String ){
        let popCV = self.storyboard?.instantiateViewController(withIdentifier: "RoverInfoViewController") as! RoverInfoViewController
        popCV.roverImgURL = roverImgURL
        popCV.roverImgDate = roverImgDate
        popCV.roverImgRoverName = roverImgRoverName
        popCV.roverImgCameraName = roverImgCameraName
        popCV.roverImgRoverStatus = roverImgRoverStatus
        popCV.roverImgLandingDate = roverImgLandingDate
        popCV.roverImgLaunchDate = roverImgLaunchDate
        popCV.view.frame.origin.y = self.view.frame.height
        popCV.view.backgroundColor = UIColor.clear
        UIView.animate(withDuration: 0.20, animations: {
            self.addChild(popCV)
            popCV.view.frame = self.view.frame
            self.view.addSubview(popCV.view)
            popCV.didMove(toParent: self)
        }) { (nil) in
            popCV.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
    }
    
}


//MARK: EXTENSIONS
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height + 30  && scrollcontrol == true{
            if self.rovers.count >= 25 {
                scrollcontrol = false
                insertNextPage()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imgURL = rovers[indexPath.row].imgSrc
        imgDate = rovers[indexPath.row].earthDate
        imgRoverName = rovers[indexPath.row].rover.name
        imgCameraName = rovers[indexPath.row].camera.name
        imgRoverStatus = rovers[indexPath.row].rover.status
        imgLandingDate = rovers[indexPath.row].rover.landingDate
        imgLaunchDate = rovers[indexPath.row].rover.launchDate
        
        showRoverInfo(roverImgURL: imgURL, roverImgDate: imgDate, roverImgRoverName: imgRoverName, roverImgCameraName: imgCameraName, roverImgRoverStatus: imgRoverStatus, roverImgLandingDate: imgLandingDate, roverImgLaunchDate: imgLaunchDate)
    }
    
    
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
