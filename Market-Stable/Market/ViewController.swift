//
//  ViewController.swift
//  Market
//
//  Created by Mona on 10/18/21.
//

import UIKit


/*
 //1.  API Contract Details:
 API Team will give webservice call details
 URL:
 GET/POST: Response
 Sample Response:
 {"Markets":[[{"Label":"$BOOB/BTC","Name":"$boob","Price":0.000000000000002070,"Volume_24h":0.00070670,"Timestamp":1638286560}}
 //2.  Hit API with URLSession class
 //3. Data, Response, Error object in CompletionHandler
 //4. By using JSONSerialisation, we converted Data to UserUnderstable formate i.e. JSON(Dictionaries)
 //5. Parse the JSON
 //6. Load JSON into Local object Ex: marketDetails
 //7. Load  datasouce into TableView/Collection
 */

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var marketDetails = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any  additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        

           self.registerTableViewCells()

        service()
    }
    
    func registerTableViewCells() {
        let marketCell = UINib(nibName: "MarketTableViewCell",
                                  bundle: nil)
        self.tableView.register(marketCell, forCellReuseIdentifier: "marketCell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marketDetails.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 184.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "marketCell") as? MarketTableViewCell {
            
            let details = marketDetails[indexPath.row]
            
            if let name = details["Name"] as? String {
                cell.nameLabel.text = "Name: \(name) "
            }
            
            if let label = details["Label"] as? String {
                cell.secondLabel.text = "Label: \(label) "
            }
            
            if let price = details["Price"] as? String {
                cell.price.text = "Price: \(price) "
            }
            
            if let volume = details["Volume_24h"] as? String {
                cell.volume.text = "Volume_: \(volume) "
            }
            
            if let timeStamp = details["Timestamp"] as? String {
                cell.timestamp.text = "Timestamp: \(timeStamp) "
            }
            
        return cell
        }
        
        return UITableViewCell()

    }
    
    
    
    func service(){
        
        guard let url  = URL(string:"https://www.worldcoinindex.com/apiservice/v2getmarkets?key=VpRQLlzQfzjY22GSCmxuRv5Wjv7CWo0yj4f&fiat=btc")
        else {
            return
        }
        
        let session = URLSession.shared
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let task = session.dataTask(with: url) { [self] (data, response, error) -> Void in
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
            
            if error != nil {
                print(error)
                
            } else {
                if let data = data {
                    
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                        
                        if jsonResult.count > 0 {
                            
                            let markets = jsonResult["Markets"] as! NSArray // pulling out data from dictonary using Markets key
                           let marketsList = markets.firstObject as! NSArray //getting first object of array
                            self.marketDetails = marketsList as! [[String : Any]] //key and any object
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                            
                        }
                        
                    } catch {
                        
                    }
                    
                }
                
            }
            
        }
        
        task.resume()
    }
}
