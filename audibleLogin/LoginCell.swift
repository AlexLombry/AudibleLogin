//
//  LoginCell.swift
//  audibleLogin
//
//  Created by Alex Lombry on 26/09/2016.
//  Copyright © 2016 Alex Lombry. All rights reserved.
//

import UIKit

class LoginCell: UICollectionViewCell {
    
    //layout audible logo
    let logoImageView: UIImageView = {
        let image = UIImage(named: "logo")
        let imageView = UIImageView(image: image)
        
        return imageView
    }()
    
    let emailTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        
        textField.placeholder = "Enter email"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.keyboardType = .emailAddress
        textField.layer.cornerRadius = 5
        
        return textField
    }()
    
    let passwordTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        
        textField.placeholder = "Enter password"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 5
        
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let btn = UIButton(type: .system)
        
        btn.backgroundColor = orangeButtonColor
        btn.setTitle("Log in", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        return btn
    }()
    
    
    // avoid retain cycle
    weak var delegate: LoginControllerDelegate?
    
    /// When the user click on login button
    func handleLogin() {
        delegate?.finishLoggingIn()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(logoImageView)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        
        _ = logoImageView.anchor(
            centerYAnchor,
            left: nil,
            bottom: nil,
            right: nil,
            topConstant: -250,
            leftConstant: 0,
            bottomConstant: 0,
            rightConstant: 0,
            widthConstant: 160,
            heightConstant: 160
        )
        
        // center the logo in the X axis
        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        _ = emailTextField.anchor(
            logoImageView.bottomAnchor,
            left: leftAnchor,
            bottom: nil,
            right: rightAnchor,
            topConstant: 10,
            leftConstant: 30,
            bottomConstant: 0,
            rightConstant: 30,
            widthConstant: 0,
            heightConstant: 50
        )
        
        _ = passwordTextField.anchor(
            emailTextField.bottomAnchor,
            left: leftAnchor,
            bottom: nil,
            right: rightAnchor,
            topConstant: 16,
            leftConstant: 30,
            bottomConstant: 0,
            rightConstant: 30,
            widthConstant: 0,
            heightConstant: 50
        )
        
        _ = loginButton.anchor(
            passwordTextField.bottomAnchor,
            left: leftAnchor,
            bottom: nil,
            right: rightAnchor,
            topConstant: 16,
            leftConstant: 30,
            bottomConstant: 0,
            rightConstant: 30,
            widthConstant: 0,
            heightConstant: 50
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class LeftPaddedTextField: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
}

