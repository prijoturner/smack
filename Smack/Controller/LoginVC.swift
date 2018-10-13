//
//  LoginVC.swift
//  Smack
//
//  Created by Prijo on 22/09/18.
//  Copyright © 2018 Prijo Turner. All rights reserved.
//

import UIKit
import SKActivityIndicatorView

class LoginVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: SMACK_PURPLE_PLACEHOLDER])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: SMACK_PURPLE_PLACEHOLDER])
    }
    
    //MARK: - Actions
    @IBAction func loginPressed(_ sender: Any) {
        SKActivityIndicator.spinnerStyle(.spinningFadeCircle)
        SKActivityIndicator.show("Loading...")
        
        guard let email = usernameTxt.text, usernameTxt.text != " " else { return }
        guard let pass = passwordTxt.text, passwordTxt.text != " " else { return }
        
        AuthService.instance.loginUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        SKActivityIndicator.dismiss()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
}
