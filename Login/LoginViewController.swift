//
//  LoginViewController.swift
//  Login
//
//  Created by Marat Cherkasov on 17.04.2023.
//

import UIKit

class LoginViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var eMailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var eMailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var envelopImageView: UIImageView!
    @IBOutlet weak var lockImageView: UIImageView!
    
    // MARK: - Properties
    private let activeColor = UIColor(named: "notes") ?? UIColor.gray
    
    private var eMail: String = "" {
        didSet {
            loginButton.isUserInteractionEnabled = !(eMail.isEmpty || password.isEmpty)
            loginButton.backgroundColor = !(eMail.isEmpty || password.isEmpty) ? activeColor : .systemGray5
            loginButton.layer.shadowColor = !(eMail.isEmpty || password.isEmpty) ? activeColor.cgColor : UIColor.gray.cgColor
        }
    }
    
    private var password: String = "" {
        didSet {
            loginButton.isUserInteractionEnabled = !(eMail.isEmpty || password.isEmpty)
            loginButton.backgroundColor = !(eMail.isEmpty || password.isEmpty) ? activeColor : .systemGray5
            loginButton.layer.shadowColor = !(eMail.isEmpty || password.isEmpty) ? activeColor.cgColor : UIColor.gray.cgColor
        }
    }
    
    private let mockEmail = "abc@gmail.com"
    private let mockPassword = "Abc123"
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLoginButton()
        eMailTextField.delegate = self
        passwordTextField.delegate = self
        eMailTextField.becomeFirstResponder()
    }
    
    // MARK: - IBActions
    @IBAction func loginButtonAction(_ sender: UIButton) {
        eMailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        if eMail.isEmpty {
            makeErrorField(textField: eMailTextField)
        }
        
        if password.isEmpty {
            makeErrorField(textField: passwordTextField)
        }
        
        if eMail == mockEmail,
           password == mockPassword {
            performSegue(withIdentifier: "goToNextScreen", sender: sender)
        } else {
            let alert = UIAlertController(title: "Error".localized,
                                          message: "Wrong e-mail or password".localized,
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "OK".localized,
                                       style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
    @IBAction func signUpButtonAction(_ sender: UIButton) {
        print("SignUp")
    }
    
    // MARK: - Private methods
    private func configureLoginButton() {
        // add shadow
        loginButton.layer.shadowOffset = CGSize(width: 1, height: 3)
        loginButton.layer.shadowOpacity = 0.7
        loginButton.layer.cornerRadius = 6
        loginButton.layer.shadowRadius = 6
        
        loginButton.isUserInteractionEnabled = false
        loginButton.backgroundColor = .systemGray5
    }
}

// MARK: - Extension for ViewController
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text?.trimmingCharacters(in:
                .whitespacesAndNewlines),
                !text.isEmpty else { return }
        
        switch textField {
        case eMailTextField:
            let isValidEmail = check(eMail: text)
            
            if isValidEmail {
                eMail = text
                envelopImageView.tintColor = .systemGray5
                eMailView.backgroundColor = .systemGray5
            } else {
                eMail = ""
                makeErrorField(textField: textField)
            }
        case passwordTextField:
            let isValidPassword = check(password: text)
            
            if isValidPassword {
                password = text
                lockImageView.tintColor = .systemGray5
                passwordView.backgroundColor = .systemGray5
            } else {
                password = ""
                makeErrorField(textField: textField)
            }
            
        default:
            print("unknown textField")
        }
    }
    
    private func check(eMail: String) -> Bool {
        let regex = /[\w_%+-]+@[\w.-]+\.(\w){2,}/
        return eMail.contains(regex)
    }
    
    private func check(password: String) -> Bool {
        let regex = /(?=[^a-z]*[a-z])(?=[^0-9]*[0-9])[a-zA-Z0-9!@#$%^&*]{6,}/
        return password.contains(regex)
    }
    
    private func makeErrorField(textField: UITextField) {
        switch textField {
        case eMailTextField:
            envelopImageView.tintColor = activeColor
            eMailView.backgroundColor = activeColor
        case passwordTextField:
            lockImageView.tintColor = activeColor
            passwordView.backgroundColor = activeColor
        default:
            print("unknown textField")
        }
    }
}
