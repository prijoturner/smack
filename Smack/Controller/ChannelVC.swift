//
//  ChannelVC.swift
//  Smack
//
//  Created by Prijo on 22/09/18.
//  Copyright © 2018 Prijo Turner. All rights reserved.
//

import UIKit
import EasyPopUp

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var tableView: UITableView!
    
    var popUpConfig = EasyPopupConfig()
    
    lazy var viewControllerPopup : EasyViewControllerPopup = {
        let popupVC = self.storyboard?.instantiateViewController(withIdentifier: "vcpopup") as! ProfileVC
        let easePopUp = EasyViewControllerPopup(sourceViewController: self, destinationViewController: popupVC )
        return easePopUp
    }()
    
    lazy var addChannelPopup : EasyViewControllerPopup = {
        let popupVC = self.storyboard?.instantiateViewController(withIdentifier: "addchannelpopup") as! AddChannelVC
        let easePopUp = EasyViewControllerPopup(sourceViewController: self, destinationViewController: popupVC )
        return easePopUp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_CHANGE, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
    }
    
    func setupUserInfo() {
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
        } else {
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
        }
    }
    
    @IBAction func addChannelPressed(_ sender: Any) {
        addChannelPopup.config = popUpConfig
        addChannelPopup.showVCAsPopup()
    }
    
    private func setupConfig(){
        popUpConfig.dimBackground = true
        popUpConfig.shadowEnabled = true
        popUpConfig.blurBackground = true
        popUpConfig.blurRadius = 10
        popUpConfig.animaionDuration = 0.4
        popUpConfig.blurTrackingMode = .common
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            setupConfig()
            viewControllerPopup.config = popUpConfig
            viewControllerPopup.showVCAsPopup()
            //performSegue(withIdentifier: "goToProfile", sender: self)
            //            let profile = ProfileVC()
            //            profile.modalPresentationStyle = .custom
            //            present(profile, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        
    }
    
    @objc func userDataDidChange(_ notif: Notification) {
        setupUserInfo()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            let channel = MessageService.instance.channel[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channel.count
    }
    
}
