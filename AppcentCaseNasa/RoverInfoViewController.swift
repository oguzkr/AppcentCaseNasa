//
//  RoverInfoViewController.swift
//  AppcentCaseNasa
//
//  Created by Oğuz Karatoruk on 21.11.2020.
//

import UIKit

class RoverInfoViewController: UIViewController {

    var roverImgURL = ""
    var roverImgDate = ""
    var roverImgRoverName = ""
    var roverImgCameraName = ""
    var roverImgRoverStatus = ""
    var roverImgLandingDate = ""
    var roverImgLaunchDate = ""
    var showing = false
    
    @IBOutlet weak var infoHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonShowInfo: UIButton!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var roverInfoView: UIView!
    @IBOutlet weak var labelRoverName: UILabel!
    @IBOutlet weak var labelCameraName: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelPhotoDate: UILabel!
    @IBOutlet weak var labelLandingDate: UILabel!
    @IBOutlet weak var labelLaunchingDate: UILabel!
    @IBOutlet weak var closeView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoView.layer.cornerRadius = 16
        infoView.clipsToBounds = true
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        setInfo()
     
    }
    
    func setInfo(){
        let url = URL(string: "\(roverImgURL)")
        imageView.sd_setImage(with: url, placeholderImage: UIImage.gif(asset: "load.gif"))
        labelRoverName.text = "Rover Name: \(roverImgRoverName)"
        labelCameraName.text = "Camera Name: \(roverImgCameraName)"
        labelStatus.text = "Status: \(roverImgRoverStatus)"
        labelPhotoDate.text = "Photo Date: \(roverImgDate)"
        labelLandingDate.text = "Landing Date: \(roverImgLandingDate)"
        labelLaunchingDate.text = "Launching Date: \(roverImgLaunchDate)"
    }
    
    func setRoverInfoView(showing: Bool) {
        if showing {
            //roverInfoView.translatesAutoresizingMaskIntoConstraints = true
            self.infoHeightConstraint.constant = 170
            UIView.animate(withDuration: 0.20) {
                self.view.layoutIfNeeded()
            }
            view.layoutIfNeeded()
            buttonShowInfo.setTitle("HIDE INFO", for: .normal)
            self.showing = true
        } else {
            //roverInfoView.translatesAutoresizingMaskIntoConstraints = true
            self.infoHeightConstraint.constant = 0
            UIView.animate(withDuration: 0.20) {
                self.view.layoutIfNeeded()
            }
            buttonShowInfo.setTitle("SHOW INFO", for: .normal)
            self.showing = false
        }
    }
    
    @IBAction func clickShowInfo(_ sender: Any) {
        showing == false ? setRoverInfoView(showing: true) : setRoverInfoView(showing: false)
    }
    
   
    
    @IBAction func clickClose(_ sender: Any) {
        UIView.animate(withDuration: 0.20, animations: {
            self.infoView.alpha = 0
            self.infoView.frame.origin.y = self.view.frame.height
        }) { (nil) in
            self.view.removeFromSuperview()
        }
    }

}


