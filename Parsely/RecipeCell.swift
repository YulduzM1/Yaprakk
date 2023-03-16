//
//  RecipeCell.swift
//  Yaprak
//
//  Created by Patrick Brothers on 4/8/22.
//

import UIKit
import Parse

class RecipeCell: UITableViewCell {

    @IBOutlet weak var recipePhotoView: UIImageView!
    
    @IBOutlet weak var recipeName: UILabel!
    
    @IBOutlet weak var prepTimeLabel: UILabel!
    
    @IBOutlet weak var cookTimeLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    var favorited: Bool = false
    var recipeId:String!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func setFavorited(_ sender: Any) {
        let toBeFavorited = !favorited
        let userId = PFUser.current()?.objectId
        if(toBeFavorited) {
            let query = PFQuery(className: "User_Favorite_Recipe")
            query.includeKeys(["recipeId", "userId", "favorited"])
            query.whereKey("recipeId", equalTo: recipeId!)
            query.whereKey("userId", equalTo: PFUser.current()!.objectId!)
            query.findObjectsInBackground() { (objects, error) in
                if objects!.count != 0 {
                    let object = objects![0]
                    object["favorited"] = true
                    object.saveInBackground { success, error in
                        if success {
                            print("success")
                            self.setFavorited(true)
                        }else{
                            print("error: \(String(describing: error?.localizedDescription))")
                        }
                    }
                } else {
                    let userFavoritesRecipe = PFObject(className: "User_Favorite_Recipe")
                    userFavoritesRecipe["recipeId"] = self.recipeId
                    userFavoritesRecipe["userId"] = userId
                    userFavoritesRecipe["favorited"] = true
                    userFavoritesRecipe.saveInBackground { (success, error) in
                        if success {
                            print("success")
                            self.setFavorited(true)
                        } else {
                            print("error: \(String(describing: error?.localizedDescription))")
                        }
                    }
                }
            }
        }else{
            let query = PFQuery(className: "User_Favorite_Recipe")
            query.includeKeys(["recipeId", "userId", "favorited"])
            query.whereKey("recipeId", equalTo: recipeId!)
            query.whereKey("userId", equalTo: PFUser.current()!.objectId!)
            query.findObjectsInBackground() { (objects, error) in
                if objects!.count != 0 {
                    let object = objects![0]
                    object["favorited"] = false
                    object.saveInBackground { success, error in
                        if success {
                            print("success")
                            self.setFavorited(false)
                        }else{
                            print("error: \(String(describing: error?.localizedDescription))")
                        }
                    }
                }
            }
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setFavorited(_ isFavorited: Bool) {
        favorited = isFavorited
        if(favorited){
            favButton.setImage(UIImage(named: "favor-icon-1"), for: UIControl.State.normal)
        }else{
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }

}
