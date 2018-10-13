//
//  ChannelCell.swift
//  Smack
//
//  Created by Prijo on 06/10/18.
//  Copyright © 2018 Prijo Turner. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var channelName: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.layer.backgroundColor = UIColor(red: 73.0/255.0, green: 196.0/255.0, blue: 161.0/255.0, alpha: 1).cgColor
            self.layer.cornerRadius = 4.0
            
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    func configureCell(channel: Channel) {
        let title = channel.channelTitle ?? ""
        channelName.text = "#\(title)"
        channelName.font = UIFont(name: "Lato-Regular", size: 17)
        
        for id in MessageService.instance.unreadChannels {
            if id == channel.id {
                channelName.font = UIFont(name: "Lato-Bold", size: 22)
            }
        }
    }
   

}
