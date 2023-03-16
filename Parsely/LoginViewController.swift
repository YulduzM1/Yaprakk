//
//  LoginViewController.swift
//  Yaprak
//
//  Created by Yulduz Muradova on 12/8/22.
//  Updated by Yulduz Muradova on 03/15/22.


import UIKit
import Parse

class LoginViewController: UIViewController {
    // Outlets for the username and password text fields
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Function to handle sign in button press
    @IBAction func onSignIn(_ sender: Any) {
        guard let username = usernameField.text, !username.isEmpty else {
            // Show an alert if the user did not enter a username
            showAlert(withTitle: "Error", message: "Please enter a username")
            return
        }
              
        guard let password = passwordField.text, !password.isEmpty else {
            // Show an alert if the user did not enter a password
            showAlert(withTitle: "Error", message: "Please enter a password")
            return
        }
        
        PFUser.logInWithUsername(inBackground: username, password: password) { user, error in
                if let error = error {
                    // Show an alert if there was an error logging in
                    self.showAlert(withTitle: "Error", message: error.localizedDescription)
                } else if user != nil {
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        
        // Create a new Parse user object with the username and password provided by the user
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        // Validate that both the username and password text fields are not empty
        guard let username = user.username, let password = user.password, !username.isEmpty, !password.isEmpty else {
            
            // Show an alert if the user did not enter a username or password
            let alert = UIAlertController(title: "Error", message: "Please enter a username and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            
            // Exit the function as validation failed
            return
        }
        
        // Attempt to sign up the new user in the background
        user.signUpInBackground { success, error in
            
            if let error = error {
                
                // Show an alert if there was an error signing up
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            } else if success {
                // Show an alert if the sign up was successful
                let alert = UIAlertController(title: "Success", message: "New account created!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    // Perform the segue to the login view
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }


        // Helper method to show an alert
    func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
