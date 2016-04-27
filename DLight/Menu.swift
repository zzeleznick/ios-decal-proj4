//
//  Menu.swift
//  DLight
//
//  Created by Zach Zeleznick on 4/26/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import Foundation

/*
Menus need to link dishes which contain wrappers for
{Nutrition, Ingredients, Merchant}
merchant info has price and pics
*/

// Set price, image from menu

class Menu: CustomStringConvertible {
    var dishes: [Dish]!
    init(dishes: [Dish]) {
        self.dishes = dishes
    }
    lazy var dict: [String:Dish] = {
        [unowned self] in
        var out = [String:Dish]()
        for dish in self.dishes {
            out[dish.id] = dish
        }
        return out }()
    var description: String {
        var tmp: [String] = []
        for dish in dishes {
            tmp.append("Dish: \(dish)")
        }
        let pre = tmp.joinWithSeparator(", ")
        let out = "Menu{\(pre)}"
        return out
    }
}

func generateSampleMenu() -> Menu {
    let names = ["Grilled Atlantic Salmon", "Petite Steak", "Garden Salad"]
    let nutritonWrappers = [0: NutritionWrapper(calories: 360, carbs: 10, protein: 34, sugar:8, fat:5),
        1: NutritionWrapper(calories: 380, carbs: 8, protein: 40, sugar: 8, fat: 8),
        2: NutritionWrapper(calories: 240, carbs: 6, protein: 2, sugar:8, fat:12)]
    let ingredientWrappers = [0: IngredientWrapper(ingredients: ["Atlantic Salmon", "3 blend seasoning", "salt"], intakeRestrictions: ["Low Sodium", "Low Calorie"], dietaryRestrictions: ["Pescatarian"]),
        1: IngredientWrapper(ingredients: ["Aged USDA Prime Steak", "3 blend seasoning", "salt"], intakeRestrictions: ["Low Sodium", "Low Calorie"], dietaryRestrictions: ["No Dairy"]),
        2: IngredientWrapper(ingredients: ["lettuce", "cucumbers", "tomatoes", "onions", "seasoning"], intakeRestrictions: ["Low Sodium", "Low Calorie"], dietaryRestrictions: ["Vegetarian"])]
    let merchantInfo = [0: MerchantWrapper(price: "$14", photo: nil),
        1: MerchantWrapper(price: "$16", photo: nil),
        2: MerchantWrapper(price: "$12", photo: nil)]
    var dishes = [Dish]()
    for i in 0..<names.count {
        let dish = Dish(name: names[i], nutrition: nutritonWrappers[i]!, ingredients: ingredientWrappers[i]!, merchant: merchantInfo[i]!)
        dishes.append(dish)
    }
    let out = Menu(dishes: dishes)
    return out
}