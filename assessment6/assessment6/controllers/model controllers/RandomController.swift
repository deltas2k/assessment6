//
//  RandomController.swift
//  assessment6
//
//  Created by Matthew O'Connor on 10/25/19.
//  Copyright © 2019 Matthew O'Connor. All rights reserved.
//

import Foundation

class RandomController {
    
    static let shared = RandomController()
    
    var nameList = [RandomName]()
    
    init() {
        loadFromPersistantStore()
    }
    
    //CRUD
    func addName(name: String, completion: @escaping(Bool) -> Void) {
        let random = RandomName(name: name)
        nameList.append(random)
        saveToPersistantStore()
        completion(true)
    }

    func remove(name: RandomName) {
        if let nameIndex = nameList.firstIndex(of: name){
            nameList.remove(at: nameIndex)
            saveToPersistantStore()
        }
    }
    
    
    
    
    
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let fileName = "random.json"
            let documentsDirectoryURL = urls[0].appendingPathComponent(fileName)
            return documentsDirectoryURL
        }
    
    func loadFromPersistantStore() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let nameList = try decoder.decode([RandomName].self, from: data)
            self.nameList = nameList
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    func saveToPersistantStore() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(nameList)
            try data.write(to: fileURL())
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
}

