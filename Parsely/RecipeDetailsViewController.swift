//
//  RecipeDetailsViewController.swift
//  Yaprak
//
//  Created by Yulduz Muradova on 12/22/22.
//  Updated by Yulduz Mruadova on 03/14/23.

import UIKit
import Parse

class RecipeDetailsViewController: UIViewController {

    var recipe: PFObject!

    @IBOutlet weak var recipeImage: UIImageView!

    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var prepTimeLabel: UILabel!
    @IBOutlet weak var cookTimeLabel: UILabel!
    
    @IBOutlet weak var ingredientsText: UITextView!
    @IBOutlet weak var stepsText: UITextView!


    override func viewDidLoad() {
        super.viewDidLoad()
        let nameRecipe = recipe["name"] as! String
        recipeNameLabel.text = nameRecipe
        let prepTime = recipe["prep_time"] as! String
        prepTimeLabel.text = prepTime
        let cookTime = recipe["cook_time"] as! String
        cookTimeLabel.text = cookTime
        let imageFile = recipe["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        recipeImage.af.setImage(withURL: url)

        let ingredients = recipe["ingredients"] as! String
        ingredientsText.text = ingredients
        let steps = recipe["instructions"] as! String
        stepsText.text = steps
        // Do any additional setup after loading the view.
    }

}
