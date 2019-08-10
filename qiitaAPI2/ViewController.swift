//
//  ViewController.swift
//  qiitaAPI2
//
//  Created by 齋藤律哉 on 2019/07/31.
//  Copyright © 2019 ritsuya. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {
  
    
   
    //var articles = [[String:Any]]()
    
    var titleArray = [Any]()
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        api()
        
        //print(titleArray)
        //tableView.reloadData()
     
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titleArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = (titleArray[indexPath.row] as! String)
        print(titleArray)
        //print(cell.textLabel?.text)
        return cell
    }
    
    func api() {
        
        let url: URL = URL(string: "https://qiita.com/api/v2/items?query=qiita+user%3Amasuhara")!
        let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            
            do {
                //JSONに変換するためのメソッド
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [Any]
                let articles = json.map { (article) -> [String: Any] in
                    return article as! [String: Any]
                }
                //print(articles)
                // print(articles[0])
                // print(articles[0]["user"])
                // print(articles[0]["title"])
                
                let count = articles.count
                //print(count)
                
                for i in 0...count-1 {
                    let title = articles[i]["title"] as! String
                    self.titleArray.append(title)
                }
                
                print(self.titleArray)
                self.tableView.reloadData()
                
            }
            catch {
                print(error)
            }
        })
        task.resume()
       // print(self.titleArray)
        
        
    }
  
    
  

}

