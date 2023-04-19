//
//  ViewController.swift
//  Login
//
//  Created by Marat Cherkasov on 17.04.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var eMailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var eMailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLoginButton()
    }
    
    // MARK: - Actions
    @IBAction func loginButtonAction(_ sender: UIButton) {
        performSegue(withIdentifier: "goToNextScreen", sender: sender)
    }
    
    @IBAction func signUpButtonAction(_ sender: UIButton) {
    }
    
    // MARK: - Methods
    private func configureLoginButton() {
        // add color
        loginButton.layer.shadowColor = UIColor.systemPink.cgColor
        
        // add shadow
        loginButton.layer.shadowOffset = CGSize(width: 1, height: 3)
        loginButton.layer.shadowOpacity = 0.7
        loginButton.layer.cornerRadius = 6
        loginButton.layer.shadowRadius = 6
    }
}
