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
    
    //MARK: - Outlets
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    var popUpConfig = EasyPopupConfig()
    
    lazy var viewControllerPopup: EasyViewControllerPopup = {
        let popupVC = self.storyboard?.instantiateViewController(withIdentifier: "vcpopup") as! ProfileVC
        let easePopUp = EasyViewControllerPopup(sourceViewController: self, destinationViewController: popupVC )
        return easePopUp
    }()
    
    lazy var addChannelPopup: EasyViewControllerPopup = {
        let popupVC = self.storyboard?.instantiateViewController(withIdentifier: "addchannelpopup") as! AddChannelVC
        let easePopUp = EasyViewControllerPopup(sourceViewController: self, destinationViewController: popupVC )
        return easePopUp
    }()
    
    
    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelsLoaded(_:)), name: NOTIF_CHANNELS_LOADED, object: nil)
        
        SocketService.instance.getChannel { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
        
        SocketService.instance.getChatMessage { (newMessage) in
            if newMessage.channelId != MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                MessageService.instance.unreadChannels.append(newMessage.channelId)
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
    }
    
    func setupUserInfo() {
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else {
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            tableView.reloadData()
        }
    }
    
    private func setupConfig(){
        popUpConfig.dimBackground = true
        popUpConfig.shadowEnabled = true
        popUpConfig.blurBackground = true
        popUpConfig.blurRadius = 10
        popUpConfig.animaionDuration = 0.4
        popUpConfig.blurTrackingMode = .common
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            let channel = MessageService.instance.channels[indexPath.row]
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
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        
        if MessageService.instance.unreadChannels.count > 0 {
            MessageService.instance.unreadChannels = MessageService.instance.unreadChannels.filter{$0 != channel.id}
        }
        let index = IndexPath(row: indexPath.row, section: 0)
        tableView.reloadRows(at: [index], with: .none)
        tableView.selectRow(at: index, animated: false, scrollPosition: .none)
        
        
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
        self.revealViewController().revealToggle(animated: true)
    }
    
    //MARK: - Actions
    @IBAction func addChannelPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn{
            addChannelPopup.config = popUpConfig
            addChannelPopup.showVCAsPopup()
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            setupConfig()
            viewControllerPopup.config = popUpConfig
            viewControllerPopup.showVCAsPopup()
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    //MARK: - Selectors
    @objc func userDataDidChange(_ notif: Notification) {
        setupUserInfo()
    }
    
    @objc func channelsLoaded(_ notif: Notification) {
        tableView.reloadData()
    }
}
