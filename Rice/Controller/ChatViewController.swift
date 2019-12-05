//
//  ChatViewController.swift
//  Rice
//
//  Created by Rachel Chua on 13/11/19.
//  Copyright © 2019 Rice. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation

class ChatViewController: UIViewController {
    
    @IBOutlet weak var mediaButton: UIButton!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var imagePartner: UIImage!
    var avatarImageView: UIImageView = UIImageView(frame: CGRect(x:0, y:0, width: 36, height: 36))
    var topLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    var partnerUsername: String!
    var partnerId: String!
    var partnerUser: User!
    var placeholderLbl = UILabel()
    var picker = UIImagePickerController()
    var messages = [Message]()
    var isActive = false
    var lastTimeOnline = ""
    var refreshControl = UIRefreshControl()
    var lastMessageKey: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPicker()
        setupInputContainer()
        setupNavigationBar()
        setupTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    @IBAction func sendBtnDidTapped(_ sender: Any) {
        
        if let text = inputTextView.text, text != "" {
            
            inputTextView.text = ""
            self.textViewDidChange(inputTextView)
            sendToFirebase(dict: ["text": text as Any])
            
        }
        
    }
    
    @IBAction func mediaBtnDidTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Rice", message: "Select Source", preferredStyle:  UIAlertController.Style.actionSheet)
        
        let camera = UIAlertAction(title:"Camera", style: UIAlertAction.Style.default) { (_) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                
                self.picker.sourceType = .camera
                self.present(self.picker, animated: true, completion: nil)
                
            } else {
                
                print("Unavailable")
                
            }
            
        }
        
        
        let library = UIAlertAction(title:"Photo Library", style: UIAlertAction.Style.default) { (_) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
                
//                FOR VIDEO UPLOADS
//                self.picker.mediaTypes = [String(kUTTypeImage), String(kUTTypeMovie)]                self.picker.sourceType = .photoLibrary
                
                self.present(self.picker, animated: true, completion: nil)
                
            } else {
                
                print("Unavailable")
                
            }
            
        }
        
//        TO TAKE VIDEO
//        let videoCamera = UIAlertAction(title: "Take a Video", style: UIAlertAction.Style.default) { (_) in
//
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
//
//            self.picker.sourceType = .camera
//            self.picker.mediaTypes = [String(kUTTypeMovie)]
//            self.picker.videoExportPreset = AVAssetExportPresetPassthrough
//            self.picker.videoMaximumDuration = 30
//            self.present(self.picker, animated: true, completion: nil)
//
//        } else {
//
//            print("Unavailable")
//
//            }
//
//        }
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert.addAction(camera)
        alert.addAction(library)
        alert.addAction(cancel)
        
//        TO TAKE VIDEO
//        alert.addAction(videoCamera)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
}
