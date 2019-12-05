//
//  PaymentApi.swift
//  Rice
//
//  Created by RUTTAB on 12/3/19.
//  Copyright © 2019 Rice. All rights reserved.
//

import Foundation
import BraintreeDropIn
import Braintree

class PaymentApi {
    
    func fetchClientToken(completion: @escaping (Bool)->Void) {
        // TODO: Switch this URL to your own authenticated API
        let clientTokenURL = NSURL(string: BRAINTREE_CLIENT_TOKEN_FETCH_URL)!
        let clientTokenRequest = NSMutableURLRequest(url: clientTokenURL as URL)
        clientTokenRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: clientTokenRequest as URLRequest) { (data, response, error) -> Void in
            // TODO: Handle errors
            let normalString = String(data: data!, encoding: String.Encoding.utf8)
            let splitArrLeading = normalString!.components(separatedBy: "client-token")
            let splitArrTrailing = splitArrLeading[1].components(separatedBy: "</s")
            
            let clientToken = splitArrTrailing[0].replacingOccurrences(of: "\">", with: "")
            SANDBOX_CLIENT_TOKEN_KEY = clientToken
            
            completion(true)
            
            print(SANDBOX_CLIENT_TOKEN_KEY)
            // As an example, you may wish to present Drop-in at this point.
            // Continue to the next section to learn more...
            }.resume()
    }
    
    
    func showBrainTreeDropIn(clientTokenOrTokenizationKey: String, vc: UIViewController, amount: Double) {
        
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: SANDBOX_CLIENT_TOKEN_KEY, request: request)
        { (controller, result, error) in
            if (error != nil) {
                print("ERROR")
            } else if (result?.isCancelled == true) {
                print("CANCELLED")
            } else if let result = result {
                // Use the BTDropInResult properties to update your UI
                _ = result.paymentOptionType
                _ = result.paymentMethod
                _ = result.paymentIcon
                _ = result.paymentDescription
             
                
                self.postNonceToServer(paymentMethodNonce: result.paymentMethod!.nonce, amount:amount)
                
            }
            controller.dismiss(animated: true, completion: nil)
        }
        DispatchQueue.main.async {
            vc.present(dropIn!, animated: true, completion: nil)
        }
    }
    
    func postNonceToServer(paymentMethodNonce: String, amount:Double) {
        // Update URL with your server
        let paymentURL = URL(string: BRAINTREE_PAYMENT_URL)!
        var request = URLRequest(url: paymentURL)
        request.httpBody = "payment_method_nonce=\(paymentMethodNonce)&amount=\(amount)".data(using: String.Encoding.utf8)
        request.httpMethod = "POST"
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
            // TODO: Handle success or failure
            let normalString = String(data: data!, encoding: String.Encoding.utf8)
            print("response charge data from server", normalString)
            
            if error != nil {
                print("response charge error from server", error)
            }
            
        }.resume()
    }
    
}
