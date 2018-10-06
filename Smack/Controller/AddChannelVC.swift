//
//  AddChannelVC.swift
//  Smack
//
//  Created by Prijo on 06/10/18.
//  Copyright © 2018 Prijo Turner. All rights reserved.
//

import UIKit
import EasyPopUp

class AddChannelVC: UIViewController {

    @IBOutlet weak var channelNameTxt: UITextField!
    @IBOutlet weak var channelDesc: UITextField!
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
    
    @IBAction func createChannelTapped(_ sender: Any) {
        
    }
    
    func setupView() {
        channelNameTxt.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedStringKey.foregroundColor: SMACK_PURPLE_PLACEHOLDER])
        channelDesc.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor: SMACK_PURPLE_PLACEHOLDER])
    }
    
}

extension AddChannelVC : EasyPopUpViewControllerDatasource {
    var popupView: UIView {
        setupView()
        return popupContentView
    }
}
