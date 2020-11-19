//
//  ViewController.swift
//  AppcentCaseNasa
//
//  Created by Oğuz Karatoruk on 19.11.2020.
//

import UIKit
import Alamofire
class ViewController: UIViewController {
    
    var currentPage = 1
    var currentTab = 1
    var network: networkManager = networkManager()
    var rovers = [Rovers]()
    
    @IBOutlet weak var segmentedView: tabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSegmented()
        clickCuriosity()
    }
    
  
    
    func setSegmented(){
        segmentedView.currentTab = currentTab
        segmentedView.buttonSegmented1.addTarget(self, action: #selector(clickCuriosity), for: .touchUpInside)
        segmentedView.buttonSegmented2.addTarget(self, action: #selector(clickOpportunity), for: .touchUpInside)
        segmentedView.buttonSegmented3.addTarget(self, action: #selector(clickSprit), for: .touchUpInside)
        segmentedView.layoutSubviews()
    }
    
    @objc func clickCuriosity() {
        currentTab = segmentedView.currentTab
        segmentedView.clickSegment1(animated: true)
        getRoverData()
        UIView.animate(withDuration: 0.2) {
            self.view.layoutSubviews()
        }
    }
    
    @objc func clickOpportunity() {
        currentTab = segmentedView.currentTab
        segmentedView.clickSegment2(animated: true)
        getRoverData()
        UIView.animate(withDuration: 0.2) {
            self.view.layoutSubviews()
        }
        
    }
    
    @objc func clickSprit() {
        currentTab = segmentedView.currentTab
        segmentedView.clickSegment3(animated: true)
        getRoverData()
        UIView.animate(withDuration: 0.2) {
            self.view.layoutSubviews()
        }
    }
    
    func getRoverData(){
        network.getRoverData(tab: currentTab, page: currentPage, completed: {
            self.rovers = self.network.rovers
            print(self.rovers[0].photos[1].imgSrc)
        })
    }


}

