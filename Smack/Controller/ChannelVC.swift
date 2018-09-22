//
//  ChannelVC.swift
//  Smack
//
//  Created by Prijo on 22/09/18.
//  Copyright © 2018 Prijo Turner. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }

}
