//
//  Network.swift
//  AppcentCaseNasa
//
//  Created by Oğuz Karatoruk on 19.11.2020.
//

import Foundation
import Alamofire
import SVProgressHUD

class networkManager {
    
    var rovers = [Photos]()
    var url = Settings.API_CURIOSITY_URL

    func getRoverData(tab:Int, page:Int, completed: @escaping () -> ()){
        SVProgressHUD.show()
        
        switch tab {
        case 1:
            url = "\(Settings.API_CURIOSITY_URL)\(page)"
        case 2:
            url = "\(Settings.API_OPPORTUNITY_URL)\(page)"
        case 3:
            url = "\(Settings.API_SPIRIT_URL)\(page)"
        default:
            url = "\(Settings.API_CURIOSITY_URL)\(page)"
        }
        
        AF.request(url).responseData { response in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let data):
                do {
                    let roverData = try JSONDecoder().decode(Rovers.self, from: data)
                    self.rovers = roverData.photos
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        completed()
                    }
                } catch let error {
                    print(error)
                    SVProgressHUD.dismiss()
                }
            }
        }.resume()
    }
    
}
