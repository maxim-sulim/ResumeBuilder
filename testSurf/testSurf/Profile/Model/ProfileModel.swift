//
//  ProfileModel.swift
//  testSurf
//
//  Created by Максим Сулим on 01.08.2023.
//

import Foundation
import UIKit

public struct Resume {
    public var nameUser: String
    public var profession: String
    public var city: String
    public var skills: [String]
    public var about: String
    public var imageUser: Data
}

extension Resume {
    
    public static func developer() -> Resume{
        
        let skills = ["ООП","MVC","Swift", "UserDefaults"]
        let image = UIImage(named: "imageProfile")
        return Resume( nameUser: "Максим Сулим Андреевич", profession: "Intern IOS developer, опыт: 1 год", city: "Санкт-Петербург", skills: skills, about: "Хороший парень, который не успел на много строк Хороший парень, который не успел на много строк Хороший парень, который не успел на много строк Хороший парень, который не успел на много строк Хороший парень, который не успел на много строк Хороший парень, который не успел на много строк Хороший парень, который не успел на много строк", imageUser: (image?.pngData())!)
    }
    
}
