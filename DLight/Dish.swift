//
//  Dish.swift
//  DLight
//
//  Created by Zach Zeleznick on 4/23/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import Foundation

class Nutrition: CustomStringConvertible {
    var calories: Int!
    var carbs: Int!
    var protein: Int!
    var sugar: Int!
    var fat: Int!
    
    init(calories: Int, carbs: Int, protein: Int, sugar:Int, fat:Int) {
        self.calories = calories
        self.carbs = carbs
        self.protein = protein
        self.sugar = sugar
        self.fat = fat
    }
    lazy var dict: [String:String] = {
        [unowned self] in
        let out: [String:String] =
        [   "Calories": "\(self.calories!) Calories",
            "Carbs": "\(self.carbs!)g",
            "Protein": "\(self.protein!)g",
            "Sugar": "\(self.sugar!)g",
            "Fat": "\(self.fat!)g",
        ]
        return out }()
    
    var description: String {
        let out =  "Nutrition{(\(self.calories)}"
        // self.members.joinWithSeparator(", ")
        return out
    }
}

class Dish: CustomStringConvertible {
    let randID = String.random(32)
    var name: String!
    var intakeRestrictions: Restrictions!
    var dietaryRestrictions: Restrictions!
    
    var nutrition: Nutrition!
    
    init(name:String, nutrition: Nutrition, intakeRestrictions: [String], dietaryRestrictions: [String]) {
            self.name = name
            self.nutrition = nutrition
            self.intakeRestrictions = Restrictions(members: intakeRestrictions)
            self.dietaryRestrictions = Restrictions(members: dietaryRestrictions)
    }
    lazy var dict: [String:String] = {
        [unowned self] in
        let out = ["Entree": self.name!,
            "Intake Restrictions": "\(self.intakeRestrictions!)",
            "Dietary Restrictions": "\(self.dietaryRestrictions!)",
        ]
        return out }()
    
    var description: String {
        let out =  "Dish{(\(self.name)}"
        return out
    }
}