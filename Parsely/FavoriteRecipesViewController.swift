//
//  FavoriteRecipesViewController.swift
//  Yaprak
//
//  Created by Yulduz Muradova on 12/22/22.
//

import UIKit
import Parse

class FavoriteRecipesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var Recipes = [PFObject]()
    var numberOfRecipes: Int!
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        myRefreshControl.addTarget(self, action: #selector(loadRecipes), for: .valueChanged)
        tableView.refreshControl = myRefreshControl

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadRecipes()
        tableView.reloadData()
        
    }
    
    @objc func loadRecipes(){        
        numberOfRecipes = 20
        let query = PFQuery(className: "User_Favorite_Recipe")
        query.limit = 20
        query.includeKeys(["userId", "recipeId", "favorited"])
        var recipeIds = [String]()
        query.whereKey("userId", equalTo: PFUser.current()!.objectId!)
        query.findObjectsInBackground() { (objects, error) in
            if objects!.count != 0 {
                for recipe in objects! {
                    if recipe["favorited"] as! Bool == true {
                        recipeIds.append(recipe["recipeId"] as! String)
                    }
                }
                
                let recipeQuery = PFQuery(className: "Recipes")
                recipeQuery.includeKeys(["name", "cook_time", "prep_time", "tags"])
                recipeQuery.whereKey("objectId", containedIn: recipeIds)
                recipeQuery.findObjectsInBackground(){ (Recipes, error) in
                    if Recipes != nil {
                        self.Recipes = Recipes!
                        self.tableView.reloadData()
                        self.myRefreshControl.endRefreshing()
                    }else{
                        print("Error \(String(describing: error))")
                    }
                    
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Recipes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteRecipeCell") as! FavoriteRecipeCell
        let recipe = Recipes[indexPath.row]
        let nameRecipe = recipe["name"] as! String
        cell.recipeName.text = nameRecipe
        let prepTime = recipe["prep_time"] as! String
        cell.prepTimeLabel.text = prepTime
        let cookTime = recipe["cook_time"] as! String
        cell.cookTimeLabel.text = cookTime
        let recipeTags = recipe["tags"] as! String
        cell.tagsLabel.text = recipeTags.split(separator: " ").joined(separator: ", ")
        let imageFile = recipe["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        cell.recipePhotoView.af.setImage(withURL: url)
        
        return cell
    }
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate
        else {return}
        delegate.window?.rootViewController = loginViewController
    }
    


}
