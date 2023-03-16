//
//  CreateRecipeViewController.swift
//  Yaprak
//
//  Created by Patrick Brothers on 4/8/22.
//

import UIKit
import Parse
import Alamofire
import AlamofireImage

class CreateRecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // IB Outlets:
    
    @IBOutlet weak var nameTextField: UITextField! // the text field where the user enters the recipe name
    
    @IBOutlet weak var prepTimeTextField: UITextField!  // the text field where the user enters the recipe prep time
    
    @IBOutlet weak var cookTimeTextField: UITextField! // the text field where the user enters the recipe cook time
    
    @IBOutlet weak var ingredientsTextView: UITextView!  // the text view where the user enters the recipe ingredients
    
    @IBOutlet weak var instructionsTextView: UITextView! // the text view where the user enters the recipe instructions
    
    @IBOutlet weak var tagsTextView: UITextView! // the text view where the user enters the recipe tags
    
    @IBOutlet weak var captionImageView: UIImageView! // the image view where the user selects a recipe image
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Helper Function to scale and set the recipe image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
    
        
        // Scale the image to a maximum size of 300x300
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageScaled(to: size)

        // Set the image view to the scaled image
        captionImageView.image = scaledImage
        dismiss(animated: true, completion: nil)
    }
    
    // Action for selecting an image for the recipe
    @IBAction func onCaptionButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        // Check if the camera is available, otherwise use the photo library
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)

    }
    
    // Action for posting the recipe to the server
    @IBAction func onPost(_ sender: Any) {
        // access api
        // populate with data from outlets (parse tags)
        // fail if user hasn't entered values
        let recipe = PFObject(className: "Recipes") // make sure you include the s!
        
        
        recipe["name"] = nameTextField.text
        recipe["prep_time"] = prepTimeTextField.text
        recipe["cook_time"] = cookTimeTextField.text
        
        recipe["ingredients"] = ingredientsTextView.text
        recipe["instructions"] = instructionsTextView.text
        
        // parse tags
        let tagString = tagsTextView.text!
        let tagArray = tagString.components(separatedBy: ",")
        recipe["tags"] = tagArray.map { (tag) -> String in
            (tag.replacingOccurrences(of: " ", with: "")).lowercased()
        }.joined(separator:" ")
        
        recipe["author"] = PFUser.current()
        
        let imageData = captionImageView.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        recipe["image"] = file
        
        recipe.saveInBackground { (success, error) in
            if success {
                print("success")
                self.dismiss(animated: true, completion: nil)
            } else {
                print("error: \(String(describing: error?.localizedDescription))")
            }
        }
    }

}
