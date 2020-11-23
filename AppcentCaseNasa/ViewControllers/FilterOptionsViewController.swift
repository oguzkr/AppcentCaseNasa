//
//  FilterOptionsViewController.swift
//  AppcentCaseNasa
//
//  Created by Oğuz Karatoruk on 23.11.2020.
//

import UIKit

class FilterOptionsViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var cameraFilterOptions = Array<String>()
    
    var selectedOption = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.layer.cornerRadius = 16
        tableView.clipsToBounds = true
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        setTableView()
    }
    
    @IBAction func closeFilterOptions(_ sender: Any) {
        closeFilterOptions(selectedOption: nil)
    }
    
    func closeFilterOptions(selectedOption: String?){
        UIView.animate(withDuration: 0.20, animations: {
            self.tableView.alpha = 0
            self.tableView.frame.origin.y = self.view.frame.height
        }) { (nil) in
            self.view.removeFromSuperview()
        }
    }
    
    func setTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = true
        tableView.frame.size.height = CGFloat(cameraFilterOptions.count * 70) //70=rowheight
    }

}

extension FilterOptionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cameraFilterOptions.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionsCell", for: indexPath) as! optionTitleTableViewCell
        cell.optionTitle.text = cameraFilterOptions[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        closeFilterOptions(selectedOption: cameraFilterOptions[indexPath.row])
        let selectedFilter:[String: String] = ["selectedFilter": cameraFilterOptions[indexPath.row]]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "filter"), object: nil, userInfo: selectedFilter)
    }

}
