//
//  StorageUser.swift
//  testSurf
//
//  Created by Максим Сулим on 05.08.2023.
//

import Foundation

protocol StorageUserProtocol {
    
    func load() -> Resume
    func save(resumeUser: Resume)
    func insertNewSkill(skill: String)
    func deleteSkill(skill: String)
}

enum ResumeProperty: String {
    case nameUser
    case profession
    case city
    case skills
    case about
    case imageUser
}


class StorageUser: StorageUserProtocol {
    
    private var storage = UserDefaults.standard
    private var storageKey = "storageKey"
    
    func load() -> Resume {
        
        let loadFromStorage = storage.dictionary(forKey: storageKey)
        
        if let name = loadFromStorage?[ResumeProperty.nameUser.rawValue],
        let profession = loadFromStorage?[ResumeProperty.profession.rawValue],
        let city = loadFromStorage?[ResumeProperty.city.rawValue],
        let skills = loadFromStorage?[ResumeProperty.skills.rawValue],
        let about = loadFromStorage?[ResumeProperty.about.rawValue],
        let image = loadFromStorage?[ResumeProperty.imageUser.rawValue] {
            
            return Resume(nameUser: name as! String, profession: profession as! String, city: city as! String, skills: skills as! [String], about: about as! String , imageUser: image as! Data)
        } else {
            
            return Resume(nameUser: "", profession: "", city: "", skills: [], about: "", imageUser: Data())
        }
    }
    
    func save(resumeUser: Resume) {
        
        var resultStorage: Dictionary<String,Any> = [:]
        
        resultStorage[ResumeProperty.nameUser.rawValue] = resumeUser.nameUser
        resultStorage[ResumeProperty.profession.rawValue] = resumeUser.profession
        resultStorage[ResumeProperty.city.rawValue] = resumeUser.city
        resultStorage[ResumeProperty.skills.rawValue] = resumeUser.skills
        resultStorage[ResumeProperty.about.rawValue] = resumeUser.about
        resultStorage[ResumeProperty.imageUser.rawValue] = resumeUser.imageUser
        
        storage.set(resultStorage, forKey: storageKey)
        
    }
    
    func insertNewSkill(skill: String) {
        
        var storageObject = storage.dictionary(forKey: storageKey)
        
        if var skills = storageObject![ResumeProperty.skills.rawValue] as? [String] {
            
            skills.append(skill)
            storageObject![ResumeProperty.skills.rawValue] = skills
            storage.removeObject(forKey: storageKey)
            storage.set(storageObject, forKey: storageKey)
            
        }
    
    }
    
    func deleteSkill(skill: String) {
        var storageObject = storage.dictionary(forKey: storageKey)
        
        if var skills = storageObject![ResumeProperty.skills.rawValue] as? [String] {
            
            for index in 0..<skills.count {
                if skills[index] == skill {
                    skills.remove(at: index)
                    break
                }
            }
            storageObject![ResumeProperty.skills.rawValue] = skills
            storage.removeObject(forKey: storageKey)
            storage.set(storageObject, forKey: storageKey)
        }
    }
    
}
