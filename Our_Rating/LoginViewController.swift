//
//  LoginViewController.swift
//  Our_Rating
//
//  Created by Ярослав Вербило on 2023-06-18.
//

import UIKit

struct KeysDefaults {
    static let keyLogin = "login"
    static let keyPassword = "password"
}

let loginTextField = UITextField()
let passwordTextField = UITextField()
let buttonLine = UIButton()
var timer: Timer?
let imageView = UIImageView()
let circleButton = UIButton()
let saveButton = UIButton()

let defaults = UserDefaults.standard

var buttonPressed = false

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.text = defaults.string(forKey: KeysDefaults.keyLogin)
        passwordTextField.text = defaults.string(forKey: KeysDefaults.keyPassword)
        
        view.backgroundColor = UIColor.init(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        
        imageView.isHidden = true
        
        setImageView()
        setLogin()
        setPassword()
        setButtonLine()
        setCircleButton()
        setSaveButton()
        
        [imageView, loginTextField, passwordTextField, buttonLine, circleButton, saveButton].forEach{
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: -40),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 350),
            imageView.heightAnchor.constraint(equalToConstant: 935),
            
            loginTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            
            buttonLine.topAnchor.constraint(equalTo: view.topAnchor, constant: 46),
            buttonLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 240),
            buttonLine.widthAnchor.constraint(equalToConstant: 3),
            buttonLine.heightAnchor.constraint(equalToConstant: 130),
            
            circleButton.topAnchor.constraint(equalTo: buttonLine.bottomAnchor),
            circleButton.centerXAnchor.constraint(equalTo: buttonLine.centerXAnchor),
            circleButton.widthAnchor.constraint(equalToConstant: 14),
            circleButton.heightAnchor.constraint(equalToConstant: 14),
            
            saveButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 100),
            saveButton.heightAnchor.constraint(equalToConstant: 30),
            
        ])
        
        func setButtonLine() {
            buttonLine.backgroundColor = .black
            buttonLine.addTarget(self, action: #selector(lineTouch), for: .touchUpInside)
        }
        
        func setCircleButton() {
            circleButton.setImage(UIImage(named: "circle"), for: .normal)
            circleButton.backgroundColor = .clear
            circleButton.addTarget(self, action: #selector(lineTouch), for: .touchUpInside)
        }
        
        func setSaveButton() {
            saveButton.backgroundColor = .blue
            saveButton.setTitle("Save", for: .normal)
            saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
            saveButton.layer.cornerRadius = 15
        }
        
        
        
    }
    
    @objc func lineTouch() {
        
        if buttonPressed {
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.0, repeats: false) { [weak self] _ in
                        textFieldShadowOn()
            
                        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [weak self] _ in
                            textFieldShadowOff()
            
                            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
                                textFieldShadowOn()
                            }
                        }
                    }
        } else {
            textFieldShadowOff()
        }
        buttonPressed.toggle()
    }
    
    @objc func saveAction() {
        let login = loginTextField.text!
        let password = passwordTextField.text!
        
        if !login.isEmpty && !password.isEmpty {
            defaults.set(login, forKey: KeysDefaults.keyLogin)
            defaults.set(password, forKey: KeysDefaults.keyPassword)
        }
    }
    
    
    
}

func setLogin() {
    loginTextField.borderStyle = .roundedRect
    loginTextField.layer.cornerRadius = 10
    loginTextField.layer.borderWidth = 5
    loginTextField.layer.borderColor = UIColor.black.cgColor
    loginTextField.backgroundColor = .clear
    loginTextField.textColor = .white
    loginTextField.attributedPlaceholder = NSAttributedString(string: "Enter Login", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)])
    
}

func setPassword() {
    passwordTextField.borderStyle = .roundedRect
    passwordTextField.layer.cornerRadius = 10
    passwordTextField.layer.borderWidth = 5
    passwordTextField.layer.borderColor = UIColor.black.cgColor
    passwordTextField.backgroundColor = .clear
    passwordTextField.textColor = .white
    passwordTextField.attributedPlaceholder = NSAttributedString(string: "Enter Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)])
    passwordTextField.isSecureTextEntry = true
}

func setImageView() {
    imageView.image = UIImage(named: "yellowTriangle")
    imageView.backgroundColor = .clear
    imageView.contentMode = .scaleAspectFill
    
}


func textFieldShadowOn() {
    passwordTextField.layer.shadowOffset.width = 2
    passwordTextField.layer.shadowOffset.height = 2
    passwordTextField.layer.shadowColor = UIColor.black.cgColor
    passwordTextField.layer.shadowOpacity = 1
    passwordTextField.layer.shadowRadius = 1
    
    loginTextField.layer.shadowOffset.width = 2
    loginTextField.layer.shadowOffset.height = 2
    loginTextField.layer.shadowColor = UIColor.black.cgColor
    loginTextField.layer.shadowOpacity = 1
    loginTextField.layer.shadowRadius = 1
    
    passwordTextField.isSecureTextEntry = false
    imageView.isHidden = false
    
}


func textFieldShadowOff() {
    passwordTextField.layer.shadowOffset.width = 0
    passwordTextField.layer.shadowOffset.height = 0
    passwordTextField.layer.shadowColor = UIColor.black.cgColor
    passwordTextField.layer.shadowOpacity = 0
    passwordTextField.layer.shadowRadius = 0
    
    loginTextField.layer.shadowOffset.width = 0
    loginTextField.layer.shadowOffset.height = 0
    loginTextField.layer.shadowColor = UIColor.black.cgColor
    loginTextField.layer.shadowOpacity = 0
    loginTextField.layer.shadowRadius = 0
    
    passwordTextField.isSecureTextEntry = true
    imageView.isHidden = true
    
}
