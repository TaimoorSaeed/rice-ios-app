//
//  Extension.swift
//  Rice
//
//  Created by Rachel Chua on 13/11/19.
//  Copyright © 2019 Rice. All rights reserved.
//

import Foundation
import SDWebImage



extension UILabel {
    func addCharacterSpacing(kernValue: Double = 3) {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}

extension UIView {
    
    class func fromNib<T: UIView>() -> T {
        
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
        
    }
    
}

extension Double {
    func calculateCostAfterServiceChargesApplied(value: String) {
        
        let serviceCost = value.stringToDouble().rounded(toPlaces: 2)
    }
    
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
}

extension UIImageView {
    
    func addBlackGradientLayer(frame: CGRect, colors:[UIColor]){
        
        
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.locations = [0.5, 1.0]
        
        gradient.colors = colors.map{$0.cgColor}
        self.layer.addSublayer(gradient)
        
    }
    
}

extension String {
    
    func estimateFrameForText(_ text: String) -> CGRect {
        
        let size = CGSize(width: 300, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)], context: nil)
        
    }
    
    func stringToDouble() -> Double {
        return Double(self) ?? 0.0
    }
}

func timeAgoSinceDate(_ date:Date, currentDate:Date, numericDates:Bool) -> String {
    let calendar = Calendar.current
    let now = currentDate
    let earliest = (now as NSDate).earlierDate(date)
    let latest = (earliest == now) ? date : now
    let components:DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute , NSCalendar.Unit.hour , NSCalendar.Unit.day , NSCalendar.Unit.weekOfYear , NSCalendar.Unit.month , NSCalendar.Unit.year , NSCalendar.Unit.second], from: earliest, to: latest, options: NSCalendar.Options())
    
    if (components.year! >= 2) {
        return "\(components.year!) years ago"
    } else if (components.year! >= 1){
        if (numericDates){ return "1 year ago"
        } else { return "Last year" }
    } else if (components.month! >= 2) {
        return "\(components.month!) months ago"
    } else if (components.month! >= 1){
        if (numericDates){ return "1 month ago"
        } else { return "Last month" }
    } else if (components.weekOfYear! >= 2) {
        return "\(components.weekOfYear!) weeks ago"
    } else if (components.weekOfYear! >= 1){
        if (numericDates){ return "1 week ago"
        } else { return "Last week" }
    } else if (components.day! >= 2) {
        return "\(components.day!) days ago"
    } else if (components.day! >= 1){
        if (numericDates){ return "1 day ago"
        } else { return "Yesterday" }
    } else if (components.hour! >= 2) {
        return "\(components.hour!) hours ago"
    } else if (components.hour! >= 1){
        if (numericDates){ return "1 hour ago"
        } else { return "An hour ago" }
    } else if (components.minute! >= 2) {
        return "\(components.minute!) mins ago"
    } else if (components.minute! >= 1){
        if (numericDates){ return "1 min ago"
        } else { return "A min ago" }
        //    } else if (components.second! >= 3) {
        //        return "\(components.second!) seconds ago"
    } else { return "Just now" }
}

extension UIImageView {
    
    func loadImage (_ urlString: String?, onSuccess: ((UIImage)-> Void)? = nil) {
        
        self.image = UIImage()
        guard let string = urlString else {return}
        guard let url = URL(string: string) else {return}
        
        self.sd_setImage(with: url) { (image, error, type, url) in
            if onSuccess != nil, error == nil {
                
                onSuccess!(image!)
                
            }
        }
        
    }
    
}

extension UIApplication {
    
    
    // PUSH NOTIFCATION TO SPECIFIC CHAT
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

extension Double {
    
    func convertDate() -> String {
        
        var string = ""
        let date: Date = Date (timeIntervalSince1970: self)
        let calendrier = Calendar.current
        let formatter = DateFormatter()
        if calendrier.isDateInToday(date) {
            
            string = ""
            formatter.timeStyle = .short
            
        } else if calendrier.isDateInYesterday(date){
            
            string = "Yesterday: "
            formatter.timeStyle = .short
            
        } else {
            
            formatter.dateStyle = .short
            
        }
        
        let dateString = formatter.string(from: date)
        return string + dateString
        
    }
    
}

extension String {
    
    var hashString: Int {
        
        let unicodeScalars = self.unicodeScalars.map { $0.value }
        return unicodeScalars.reduce(5381) {
            
            ($0 << 5) &+ $0 &+ Int($1)
            
        }
    }
    
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date = dateFormatter.date(from: self)!
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        
        let finalDate = calendar.date(from:components)
        
        return finalDate!
    }
    
    
    func toTime() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date = dateFormatter.date(from: self)!
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        
        let finalDate = calendar.date(from:components)
        
        return finalDate!
    }
}

extension Date {
    

    
    func toString(dateFormat format: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
        
    }
    
}

extension UIViewController {
    

    
}
