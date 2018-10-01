//
//  Constants.swift
//  Smack
//
//  Created by Prijo on 22/09/18.
//  Copyright © 2018 Prijo Turner. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

//Segues
let TO_LOGIN = "goToLogin"
let TO_CREATE_ACCOUNT = "goToCreateAcc"
let UNWIND_TO_CHANNEL = "unwindToChannel"
let TO_AVATAR_PICKER = "goToAvatarPicker"

//Color
let SMACK_PURPLE_PLACEHOLDER = #colorLiteral(red: 0.4156079888, green: 0.2096392512, blue: 0.2073965073, alpha: 0.9531785103)

//Notifications Constants
let NOTIF_USER_DATA_CHANGE = Notification.Name("notifUserDataChanged")

//User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//URL Constants
let BASE_URL = "https://chattychatprijo.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"

//Header
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]
