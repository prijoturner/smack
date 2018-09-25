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

//User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//URL Constants
let BASE_URL = "https://chattychatprijo.herokuapp.com/"
let URL_REGISTER = "\(BASE_URL)account/register"
