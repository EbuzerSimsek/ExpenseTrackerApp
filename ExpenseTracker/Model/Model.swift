//
//  Model.swift
//  ExpenseTracker
//
//  Created by Ebuzer Şimşek on 14.07.2023.
//

import Parse

class User: PFUser {
    @NSManaged var name: String?
    @NSManaged var income: Double
    @NSManaged var expense: Double
    @NSManaged var salary: Double
    @NSManaged var image : UIImage
}





