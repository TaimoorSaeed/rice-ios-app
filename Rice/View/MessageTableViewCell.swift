//
//  MessageTableViewCell.swift
//  Rice
//
//  Created by Rachel Chua on 14/11/19.
//  Copyright © 2019 Rice. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textMessageLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var photoMessage: UIImageView!
    @IBOutlet weak var headerTimeLabel: UILabel!
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var bubbleLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var bubbleRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        bubbleView.layer.cornerRadius = 15
        bubbleView.clipsToBounds = true
        bubbleView.layer.borderWidth = 0.4
        textMessageLabel.numberOfLines = 0
        photoMessage.layer.cornerRadius = 15
        photoMessage.clipsToBounds = true
        profileImage.layer.cornerRadius = 16
        profileImage.clipsToBounds = true
        
        photoMessage.isHidden = true
        profileImage.isHidden = true
        textMessageLabel.isHighlighted = true
        
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        photoMessage.isHidden = true
        profileImage.isHidden = true
        textMessageLabel.isHighlighted = true
        
    }
    
    func configureCell(uid: String, message: Message, image: UIImage) {
        
        let text = message.text
        if !text.isEmpty {
            
            textMessageLabel.text = message.text
            photoMessage.loadImage(message.imageUrl)
            
            let widthValue = text.estimateFrameForText(text).width + 40
            if widthValue < 120 {
                
                widthConstraint.constant = 120
                
            } else {
                
                widthConstraint.constant = widthValue
                
            }
            
            dateLabel.textColor = .lightGray
    
        } else {
            
            photoMessage.isHidden = false
            photoMessage.loadImage(message.imageUrl)
            bubbleView.layer.borderColor = UIColor.clear.cgColor
            widthConstraint.constant = 250
            dateLabel.textColor = .white

        }
        
        if uid == message.from {
            
            bubbleView.backgroundColor = UIColor.systemGroupedBackground
            bubbleView.layer.borderColor = UIColor.clear.cgColor
            bubbleRightConstraint.constant = 8
            bubbleLeftConstraint.constant = UIScreen.main.bounds.width - widthConstraint.constant - bubbleRightConstraint.constant
            
        } else {
            
            profileImage.isHidden = false
            bubbleView.backgroundColor = UIColor.white
            profileImage.image = image
            bubbleView.layer.borderColor = UIColor.lightGray.cgColor
            bubbleLeftConstraint.constant = 55
            bubbleRightConstraint.constant = UIScreen.main.bounds.width - widthConstraint.constant - bubbleLeftConstraint.constant
            
        }
        
        let date = Date(timeIntervalSince1970: message.date)
        let dateString = timeAgoSinceDate(date, currentDate: Date(), numericDates: true)
        dateLabel.text = dateString
        self.formatHeaderTimeLabel(time: date) { (text) in
            self.headerTimeLabel.text = text
        }
        
}
    
    func formatHeaderTimeLabel(time: Date, completion: @escaping (String) -> ()) {
        
        var text = ""
        let currentDate = Date()
        let currentDateString = currentDate.toString(dateFormat: "yyyyMMdd")
        let pastDateString = time.toString(dateFormat: "yyyyMMdd")
        print(currentDateString)
        
        if pastDateString.elementsEqual(currentDateString) == true {
            
            text = time.toString(dateFormat: "HH:mm a") + ", Today"
            
        } else {
            
            text = time.toString(dateFormat: "dd/MM/yyyy")
            
        }
        
        completion(text)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


