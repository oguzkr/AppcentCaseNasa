//
//  Model.swift
//  AppcentCaseNasa
//
//  Created by Oğuz Karatoruk on 19.11.2020.
//

import Foundation

// MARK: - Rovers
struct Rovers: Codable {
    let photos: [Photos]
}

// MARK: - Photo
struct Photos: Codable {
    let id, sol: Int
    let camera: Camera
    let imgSrc: String
    let earthDate: String
    let rover: Rover

    enum CodingKeys: String, CodingKey {
        case id, sol, camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
}

// MARK: - Camera
struct Camera: Codable {
    let id: Int
    let name: String //CameraName
    let roverID: Int
    let fullName: String //FullName

    enum CodingKeys: String, CodingKey {
        case id, name
        case roverID = "rover_id"
        case fullName = "full_name"
    }
}

//enum FullName: String, Codable {
//    case frontHazardAvoidanceCamera = "Front Hazard Avoidance Camera"
//    case mastCamera = "Mast Camera"
//    case rearHazardAvoidanceCamera = "Rear Hazard Avoidance Camera"
//}
//
//enum CameraName: String, Codable {
//    case fhaz = "FHAZ"
//    case mast = "MAST"
//    case rhaz = "RHAZ"
//}

// MARK: - Rover
struct Rover: Codable {
    let id: Int
    let name: String //RoverName
    let landingDate, launchDate: String
    let status: String //Status

    enum CodingKeys: String, CodingKey {
        case id, name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
    }
}

//enum RoverName: String, Codable {
//    case curiosity = "Curiosity"
//}
//
//enum Status: String, Codable {
//    case active = "active"
//}
