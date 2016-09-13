//
//  Walk+CoreDataProperties.swift
//  DogWalk
//
//  Created by User on 9/13/16.
//  Copyright © 2016 Elijah Buters. All rights reserved.
//

import Foundation
import CoreData

extension Walk {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Walk> {
        return NSFetchRequest<Walk>(entityName: "Walk");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var dog: Dog?

}
