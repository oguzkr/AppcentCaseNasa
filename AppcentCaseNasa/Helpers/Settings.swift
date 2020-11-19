//
//  Settings.swift
//  AppcentCaseNasa
//
//  Created by Oğuz Karatoruk on 19.11.2020.
//

import Foundation
import UIKit

struct Settings {
    static let API_KEY:String = "IWisOoZWRJb6piyGeakRIezkdpGahe6VXOd5yJbR"
    static let API_CURIOSITY_URL:String = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=\(API_KEY)&page="
    static let API_OPPORTUNITY_URL:String = "https://api.nasa.gov/mars-photos/api/v1/rovers/opportunity/photos?sol=1000&api_key=\(API_KEY)&page="
    static let API_SPIRIT_URL:String = "https://api.nasa.gov/mars-photos/api/v1/rovers/spirit/photos?sol=1000&api_key=\(API_KEY)&page="
    
    static let nasaLightColor = UIColor(named: "nasaLightColor")
    static let nasaColor = UIColor(named: "nasaColor")
}
