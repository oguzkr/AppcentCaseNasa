//
//  tabBar.swift
//  AppcentCaseNasa
//
//  Created by Oğuz Karatoruk on 19.11.2020.
//

import UIKit

@IBDesignable
class tabBar: UIView {
    
    @IBOutlet weak var buttonSegmented1: UIButton!
    @IBOutlet weak var buttonSegmented2: UIButton!
    @IBOutlet weak var buttonSegmented3: UIButton!
    
    @IBOutlet weak var imageSegmentedLine: UIImageView!
    
    var currentTab = Int()

    override init(frame: CGRect) {
        super.init(frame: frame)
        ownFirstNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        ownFirstNib()
    }
    
    func clickSegment1(animated: Bool){
        var duration:Double = 0
        if animated == true {
            duration = 0.2
        } else {
            duration = 0
        }
        currentTab = 0
        imageSegmentedLine.translatesAutoresizingMaskIntoConstraints = true
        UIView.animate(withDuration: duration) {
            self.imageSegmentedLine.center.x = self.buttonSegmented1.center.x
            self.buttonSegmented1.setTitleColor(Settings.nasaColor, for: .normal)
            self.buttonSegmented2.setTitleColor(Settings.nasaLightColor, for: .normal)
            self.buttonSegmented3.setTitleColor(Settings.nasaLightColor, for: .normal)
        }
    }
    
    func clickSegment2(animated: Bool){
        var duration:Double = 0
        if animated == true {
            duration = 0.2
        } else {
            duration = 0
        }
        currentTab = 1
        imageSegmentedLine.translatesAutoresizingMaskIntoConstraints = true
        UIView.animate(withDuration: duration) {
            self.imageSegmentedLine.center.x = self.buttonSegmented2.center.x
            self.buttonSegmented1.setTitleColor(Settings.nasaLightColor, for: .normal)
            self.buttonSegmented2.setTitleColor(Settings.nasaColor, for: .normal)
            self.buttonSegmented3.setTitleColor(Settings.nasaLightColor, for: .normal)
        }
    }
    
    func clickSegment3(animated: Bool){
        var duration:Double = 0
        if animated == true {
            duration = 0.2
        } else {
            duration = 0
        }
        currentTab = 2
        imageSegmentedLine.translatesAutoresizingMaskIntoConstraints = true
        UIView.animate(withDuration: duration) {
            self.imageSegmentedLine.center.x = self.buttonSegmented3.center.x
            self.buttonSegmented1.setTitleColor(Settings.nasaLightColor, for: .normal)
            self.buttonSegmented2.setTitleColor(Settings.nasaLightColor, for: .normal)
            self.buttonSegmented3.setTitleColor(Settings.nasaColor, for: .normal)
        }
    }
    
    

    
}
