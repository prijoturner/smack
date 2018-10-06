//
//  ViewControllerExample.swift
//  EasyPopUp_Example
//
//  Created by Mohammad Zakizadeh on 6/8/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import EasyPopUp

class ProfileVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var profileImage: UIImageView?
    @IBOutlet weak var userName: UILabel?
    @IBOutlet weak var userEmail: UILabel?
    @IBOutlet weak var popUpBg: UIImageView!
    
    @IBOutlet weak var popupContentView: UIView! {
        didSet {
            popUpBg.layer.cornerRadius = 8
            popUpBg.clipsToBounds = true
            popupContentView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var dismissButton: UIButton! {
        didSet {
            dismissButton.layer.cornerRadius = dismissButton.frame.height/2
        }
    }
    
    @IBAction func dismissVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        userName?.text = UserDataService.instance.name
        userEmail?.text = UserDataService.instance.email
        profileImage?.image = UIImage(named: UserDataService.instance.avatarName)
    }
}

extension ProfileVC : EasyPopUpViewControllerDatasource {
    var popupView: UIView {
        setupView()
        return popupContentView
    }
}
