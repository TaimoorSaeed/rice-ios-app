//
//  NewMatchTableViewController.swift
//  Rice
//
//  Created by Rachel Chua on 20/11/19.
//  Copyright © 2019 Rice. All rights reserved.
//

import UIKit

class NewMatchTableViewController: UITableViewController {
    
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        observeUsers()
        setupTableView()
        
    }
    
    func setupTableView() {
        
        tableView.tableFooterView = UIView()
        
    }
    
    func setupNavigationBar() {
        
        title = "New Match"
        let iconView = UIImageView(image: UIImage(named: ""))
        iconView.contentMode = .scaleAspectFit
        navigationItem.titleView = iconView
        
    }
    
    func observeUsers() {
        
        Api.User.observeNewMatch { (user) in
            
            self.users.append(user)
            self.tableView.reloadData()
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.users.count
        
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IDENTIFIER_CELL_USERS, for: indexPath) as! UserTableViewCell

        let user = users[indexPath.row]
        
        cell.delegate = self
        cell.loadData(user)
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 107
        
    }
    
    override func tableView (_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as?
            UserTableViewCell {
            
            let storyboard = UIStoryboard(name: "Welcome", bundle: nil)
            
            let chatVC = storyboard.instantiateViewController(withIdentifier: IDENTIFIER_CHAT) as! ChatViewController
            
            chatVC.imagePartner = cell.avatar.image
            chatVC.partnerUsername = cell.usernameLbl.text
            chatVC.partnerId = cell.user.uid
            chatVC.partnerUser = cell.user
            
            self.navigationController?.pushViewController(chatVC, animated: true)
            
        }
    }
    
    
}

extension NewMatchTableViewController: UpdateTableProtocol {
    
    func reloadData() {
        
        self.tableView.reloadData()
        
    }
    
    func MatchesTableViewCell(_ matchesTableViewCell: UserTableViewCell, subscribeButtonTappedFor user: User) {
        
        Api.User.remNewMatch(us: user)
            let alert = UIAlertController(title: "Unmatched!", message: "Unmatched from \(user.username)", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        
        users.removeAll()
        observeUsers()
        
        

        

    }
    
}
