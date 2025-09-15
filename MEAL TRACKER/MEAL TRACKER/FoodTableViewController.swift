//
//  FoodTableViewController.swift
//  MEAL TRACKER
//
//  Created by Student on 25/08/25.
//

import UIKit

class FoodTableViewController: UITableViewController {
    
    var meals: [Meal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Example meals
        let breakfast = Meal(name: "Breakfast", foods: [
            Food(name: "Pancakes"),
            Food(name: "Eggs"),
            Food(name: "Juice")
        ])
        
        let lunch = Meal(name: "Lunch", foods: [
            Food(name: "Sandwich"),
            Food(name: "Salad")
        ])
        
        let dinner = Meal(name: "Dinner", foods: [
            Food(name: "Pasta"),
            Food(name: "Soup"),
            Food(name: "Ice Cream")
        ])
        
        meals = [breakfast, lunch, dinner]
    }
    
    // Number of sections = number of meals
    override func numberOfSections(in tableView: UITableView) -> Int {
        return meals.count
    }
    
    // Rows = number of foods in each meal
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals[section].foods.count
    }
    
    // Configure each cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Food", for: indexPath)
        
        let meal = meals[indexPath.section]
        let food = meal.foods[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = food.name
        //content.secondaryText = meal.name
        cell.contentConfiguration = content
        
        return cell
    }
    
    // Section headers
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return meals[section].name
    }
}
