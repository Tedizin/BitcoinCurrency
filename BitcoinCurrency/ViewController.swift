//
//  ViewController.swift
//  BitcoinCurrency
//
//  Created by Henrique Silva on 18/05/21.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    //MARK: - Constats
    
    let baseUrl = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTCAUD"
    let currencies = [""]
    
    //MARK: - Variables
    
    var publicKey = "ZDMwYTMzN2Q2MmU4NDA4YWEwZDE0NDU1MTk1Y2Q5NjE"
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fethData(url: baseUrl)
    }
    
    func fethData(url: String) {

        let url = URL(string: url)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(publicKey, forHTTPHeaderField: "x-ba-key")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let dataString = String(data: data, encoding: .utf8)
                print(dataString!)
            } else {
                print("DEU TUDO ERRADO")
            }
        }
        task.resume()
    }
}

