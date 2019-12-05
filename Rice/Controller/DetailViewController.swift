//
//  DetailViewController.swift
//  Rice
//
//  Created by Rachel Chua on 19/11/19.
//  Copyright © 2019 Rice. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var tempImage: UIImageView!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var user: User!
    
    @IBAction func backBtnDidTapped(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func sendBtnDidTapped(_ sender: Any) {
                    
            let storyboard = UIStoryboard(name: "Welcome", bundle: nil)
            
            let chatVC = storyboard.instantiateViewController(withIdentifier: IDENTIFIER_CHAT) as! ChatViewController
            
            chatVC.imagePartner = avatar.image
            chatVC.partnerUsername = usernameLbl.text
            chatVC.partnerId = user.uid
            chatVC.partnerUser = user
            
            self.navigationController?.pushViewController(chatVC, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sendBtn.layer.cornerRadius = 5
        sendBtn.clipsToBounds = true
        
        let backImg = UIImage (named: "close")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        backBtn.setImage(backImg, for: UIControl.State.normal)
        backBtn.tintColor = .white
        
        backBtn.layer.cornerRadius = 35/2
        backBtn.clipsToBounds = true
        
        self.avatar.loadImage(user.profileImageUrl)
        
        let frameGradient = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 350)
        avatar.addBlackGradientLayer(frame: frameGradient, colors: [.clear, .black])
        
        usernameLbl.text = user.username
        if user.age != nil {
            
            ageLbl.text = " \(user.age!)"
            
        } else {
            
            ageLbl.text = ""
            
        }
        
        if let isTemporary = user.isTemporary {
            
            let tempImgName = (isTemporary == true) ? "icon-male" : "icon-female"
            tempImage.image = UIImage(named: tempImgName)?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            
        } else {
            
            tempImage.image = UIImage(named: "icon-gender")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            
        }
        
        tempImage.tintColor = .white
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        
    }

}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 8
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            cell.imageView?.image = UIImage(named: "phone")
            cell.textLabel?.text = user.contactNum
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            cell.imageView?.image = UIImage(named: "map-1")
            cell.textLabel?.text = user.email
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            cell.textLabel?.text = user.status
            cell.selectionStyle = .none
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath)
            
            var occ: String? = user.Occupation
            if(occ == nil || occ == ""){
                occ = "Occupation Not Provided"
            }
            
            cell.textLabel?.text = occ
            
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.numberOfLines = 0
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath)
            var ind: String? = user.Industry
            if(ind == nil || ind == ""){
                ind = "Industry Not Provided"
            }
            
            cell.textLabel?.text = ind
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.numberOfLines = 0
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath)
            
            var bio: String? = user.Bio
            if(bio == nil || bio == ""){
                bio = "Bio Not Provided"
            }
            
            cell.textLabel?.text = bio
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.numberOfLines = 0
            return cell
        default:
            break
            
        }
        
        return UITableViewCell()
        
    }
    

    
}
