//
//  ViewController.swift
//  AppcentCaseNasa
//
//  Created by Oğuz Karatoruk on 19.11.2020.
//

import UIKit

class ViewController: UIViewController {
    
    var page = 1
    var url = Settings.API_CURIOSITY_URL
    var currentTab = 1
    
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
        url = Settings.API_CURIOSITY_URL
        UIView.animate(withDuration: 0.2) {
            self.view.layoutSubviews()
        }
    }
    
    @objc func clickOpportunity() {
        currentTab = segmentedView.currentTab
        segmentedView.clickSegment2(animated: true)
        url = Settings.API_OPPORTUNITY_URL
        UIView.animate(withDuration: 0.2) {
            self.view.layoutSubviews()
        }
    }
    
    @objc func clickSprit() {
        currentTab = segmentedView.currentTab
        segmentedView.clickSegment3(animated: true)
        url = Settings.API_SPIRIT_URL
        UIView.animate(withDuration: 0.2) {
            self.view.layoutSubviews()
        }
    }


}

