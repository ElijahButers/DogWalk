//
//  CoreDataStack.swift
//  DogWalk
//
//  Created by User on 9/13/16.
//  Copyright © 2016 Elijah Buters. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    let modelName = "Dog Walk"
    
    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()
}
