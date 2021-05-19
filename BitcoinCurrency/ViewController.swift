//
//  ViewController.swift
//  BitcoinCurrency
//
//  Created by Henrique Silva on 18/05/21.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyPickerView: UIPickerView!
    
    //MARK: - Constats
    
    let baseUrl = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTCAUD"
    let curruncies = ["AUD", "BRL", "CAD", "CNY", "EUR", "OBP", "HKD", "IDR", "ILS", "INR", "JPY","MXN","NOK","PLN","RON","RUB","SEK","SOD","USD","ZAR"]
    
    //MARK: - Variables
    
    var publicKey = "ZDMwYTMzN2Q2MmU4NDA4YWEwZDE0NDU1MTk1Y2Q5NjE"
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(url: baseUrl)
        currencyPickerView.delegate = self
        currencyPickerView.dataSource = self
        
    }
    
    //MARK: - PickerView
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return curruncies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return curruncies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let url = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC\(curruncies[row])"
        fetchData(url: url)
        }
    
    //MARK: - Data
    
    func fetchData(url: String) {

        let url = URL(string: url)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(publicKey, forHTTPHeaderField: "x-ba-key")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                self.parseJSON(json: data)
            } else {
                print("DEU TUDO ERRADO")
            }
        }
        task.resume()
    }
    
    //MARK: - JSON
    
    func parseJSON(json: Data) {
        
        do {
            
            if let json = try JSONSerialization.jsonObject(with: json, options: .mutableContainers) as? [String: Any] {
                print(json)
                if let askValue = json["ask"] as? NSNumber {
                    print(askValue)
                    
                    let askvalueString = "R$\(askValue)"
                    DispatchQueue.main.async {
                        
                        self.priceLabel.text = askvalueString
                    }
                    print("success")
                } else {
                    print("error")
                }
            }
        } catch {
            
            print("error parsing json: \(error)")
        }
    }
}

