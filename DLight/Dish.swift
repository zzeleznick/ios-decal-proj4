//
//  Dish.swift
//  DLight
//
//  Created by Zach Zeleznick on 4/23/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import Foundation
import UIKit

class NutritionWrapper: CustomStringConvertible {
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
        let tmp = [String](dict.keys)
        let pre = tmp.joinWithSeparator(",")
        let out =  "Nutrition{\(pre)}"
        return out
    }
}

class IngredientWrapper: CustomStringConvertible {
    var ingredients: [String]!
    var intakeRestrictions: Restrictions!
    var dietaryRestrictions: Restrictions!
    
    init(ingredients: [String],intakeRestrictions: [String],dietaryRestrictions: [String]) {
        self.ingredients = ingredients
        self.intakeRestrictions = Restrictions(members: intakeRestrictions)
        self.dietaryRestrictions = Restrictions(members: dietaryRestrictions)
    }
    
    var description: String {
        let pt1 = ingredients.joinWithSeparator(", ")
        let pt2 = intakeRestrictions.description
        let pt3 = dietaryRestrictions.description
        let tmp = ["Ingredients: \(pt1)",
                  "Intake Restrictions: \(pt2)",
                  "Dietary Restrictions: \(pt3)"
        ].joinWithSeparator(", ")
        let out = "IngredientWrapper{\(tmp)}"
        return out
    }
}

class MerchantWrapper {
    var price: String!
    var photo: UIImage?
    let randID = String.random(32)
    init(price: String, photo: UIImage?) {
        self.price = price
        self.photo = photo
    }
}


class Dish: CustomStringConvertible {
    var name: String!
    var nutrition: NutritionWrapper!
    var ingredients: IngredientWrapper!
    var merchant: MerchantWrapper!
    // from children
    var intakeRestrictions: Restrictions!
    var dietaryRestrictions: Restrictions!
    var id: String!

    init(name:String, nutrition: NutritionWrapper,
        ingredients: IngredientWrapper, merchant: MerchantWrapper) {
            self.name = name
            self.nutrition = nutrition
            self.ingredients = ingredients
            self.merchant = merchant
            // from children
            self.intakeRestrictions = ingredients.intakeRestrictions
            self.dietaryRestrictions = ingredients.dietaryRestrictions
            self.id = merchant.randID
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

func generateSampleDish() -> Dish {
    let nutrition = NutritionWrapper(calories: 360, carbs: 10, protein: 34, sugar:8, fat:5)
    let ingredients = IngredientWrapper(ingredients: ["Atlantic Salmon", "3 blend seasoning", "salt"], intakeRestrictions: ["Low Sodium", "Low Calorie"], dietaryRestrictions: ["Pescatarian"])
    let merchantInfo = MerchantWrapper(price: "$14", photo: nil)
    let dish = Dish(name: "Grilled Atlantic Salmon",
        nutrition: nutrition,
        ingredients: ingredients,
        merchant: merchantInfo)
    return dish
}
