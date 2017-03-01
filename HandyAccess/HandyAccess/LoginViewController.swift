//
//  ViewController.swift
//  HandyAccess
//
//  Created by Karen Fuentes on 2/17/17.
//  Copyright © 2017 NYCHandyAccess. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import FirebaseAuth


class LoginViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate {
    
    let databaseReference = FIRDatabase.database().reference().child("Users")
    var databaseObserver:FIRDatabaseHandle?
    var signInUser: FIRUser?
    var users = [Users]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "LOGIN/REGISTER"
        self.view.backgroundColor = UIColor.lightGray

        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        setupViewHierarchy()
        configureConstraints()
        
        let mapVC = MapViewController()
        if FIRAuth.auth()?.currentUser != nil {
            self.navigationController?.pushViewController(mapVC, animated: true)

        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            emailTextField.resignFirstResponder()
        case passwordTextField:
            passwordTextField.resignFirstResponder()
        default:
            break
        }
        return true
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureConstraints()
        resetButtonColors()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        _ = [logoImageView, emailLineView, passwordLineView, passwordTextField, emailTextField, loginButton, registerButton].map{ $0.isHidden = false }
        

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        resetButtonColors()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.resetViews()
        //self.removeBehaviors()
        self.removeConstraints()
    }

    // MARK: - Tear Down
    
//    internal func removeBehaviors() {
//        self.propertyAnimator = nil
//    }
    
    internal func resetViews() {
        _ = [logoImageView, emailLineView, passwordLineView, passwordTextField, emailTextField, loginButton, registerButton].map{ $0.isHidden = true }
    }
    
    private func removeConstraints() {
        _ = [logoImageView, emailLineView, passwordLineView, passwordTextField, emailTextField, loginButton, registerButton].map { $0.snp.removeConstraints() }
    }

    
    func setupViewHierarchy() {
        self.edgesForExtendedLayout = []

        self.view.addSubview(logoImageView)
        self.view.addSubview(emailTextField)
        self.view.addSubview(emailLineView)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(passwordLineView)
        self.view.addSubview(loginButton)
        self.view.addSubview(registerButton)
        
        loginButton.addTarget(self, action: #selector(didTapLogin(sender:)) , for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registeredPressed(sender:)), for: .touchUpInside)
    }
    
    func configureConstraints() {
        
        logoImageView.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalToSuperview().offset(10)
            view.width.height.equalTo(250.0)
        }
        
        emailTextField.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.width.equalToSuperview().multipliedBy(0.8)
            view.top.equalTo(logoImageView.snp.bottom).offset(40)
        }
        
        emailLineView.snp.makeConstraints { (view) in
            view.leading.trailing.equalTo(emailTextField)
            view.top.equalTo(emailTextField.snp.bottom)
            view.height.equalTo(1)
        }
        
        passwordTextField.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.width.equalToSuperview().multipliedBy(0.8)
            view.top.equalTo(emailTextField.snp.bottom).offset(30)
        }
        
        passwordLineView.snp.makeConstraints { (view) in
            view.leading.trailing.equalTo(passwordTextField)
            view.top.equalTo(passwordTextField.snp.bottom)
            view.height.equalTo(1)
        }
        
        registerButton.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.bottom.equalTo(bottomLayoutGuide.snp.top).offset(-55)
            view.leading.equalToSuperview().offset(70)
            view.trailing.equalToSuperview().inset(70)
            view.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.bottom.equalTo(registerButton.snp.top).inset(-10)
            view.width.equalTo(registerButton)
            view.height.equalTo(registerButton)
        }

    }
    
    // MARK: - Actions
    
    func didTapLogin(sender: UIButton) {
        sender.backgroundColor = UIColor.darkGray
        sender.setTitleColor(.black, for: .normal)
        
        if let email = emailTextField.text,
            let password = passwordTextField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user: FIRUser?, error: Error?) in
                
                
                if user != nil {
                    let newViewController = MapViewController()
                    if let tabVC =  self.navigationController {
                        tabVC.show(newViewController, sender: nil)
                    }
                } else {
                    self.resetButtonColors()
                }
            })
        }
    }
    
    func registeredPressed(sender: UIButton) {
        sender.backgroundColor = UIColor.darkGray
        sender.setTitleColor(.black, for: .normal)
        
        
        if let email = emailTextField.text,
            let password = passwordTextField.text {
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error: Error?) in
                if error != nil {
                    print (error)
                    return
                }
                guard let uid = user?.uid else {return}
                let values = ["email": email]
                
                self.registerUserIntoDatabaseWithUID(uid: uid, values: values)
                
            })
        }
    }
    
    private func registerUserIntoDatabaseWithUID(uid: String, values: [String: Any]) {
        
        let userReference = self.databaseReference.child(uid)
        userReference.updateChildValues(values)
        
        let newViewController = MapViewController()
        if let tabVC =  self.navigationController {
            tabVC.show(newViewController, sender: nil)
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetButtonColors()
    }
    
    
    func resetButtonColors() {
        loginButton.backgroundColor = UIColor.darkGray
        loginButton.setTitleColor(.black, for: .normal)
        
        registerButton.backgroundColor = UIColor.darkGray
        registerButton.setTitleColor(.black, for: .normal)
    }
    
    
        //MARK: -Lazy Properties


    lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "logo")
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 5
        return view
    }()
    
    lazy var emailTextField: UITextField = {
        let view = UITextField()
        view.text = "Email"
        view.textAlignment = .left
        view.textColor = .yellow
        view.clipsToBounds = false
        return view
    }()
    
    internal lazy var emailLineView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    lazy var passwordTextField: UITextField = {
        let view = UITextField()
        view.text = "Password"
        view.textColor = .yellow
        view.textAlignment = .left
        return view
    }()
    
    internal lazy var passwordLineView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = UIColor.lightGray
        
        return view
    }()
    
    lazy var loginButton: UIButton = {
        let button: UIButton = UIButton(type: .roundedRect)
        button.setTitle("LOGIN", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightSemibold)
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.contentEdgeInsets = UIEdgeInsetsMake(15.0, 0.0, 15.0, 0.0)
        button.alpha = 0.6
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button: UIButton = UIButton(type: .roundedRect)
        button.setTitle("REGISTER", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightSemibold)
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.contentEdgeInsets = UIEdgeInsetsMake(15.0, 0.0, 15.0, 0.0)
        button.alpha = 0.6
        return button
    }()
    
   

    
}

