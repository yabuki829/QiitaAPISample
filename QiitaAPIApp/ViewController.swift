//
//  ViewController.swift
//  QiitaAPIApp
//
//  Created by Yabuki Shodai on 2021/09/15.
//

import UIKit

class ViewController: UIViewController {


    
    @IBOutlet weak var tableView: UITableView!
    var articleQiitas = [QiitaStruct]()
    var tag = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getAPI()
        // Do any additional setup after loading the view.
    }

    func getAPI(){
        print("APIを取得します")
        
        var httpsString = String()
        if tag == ""{
             httpsString = "https://qiita.com/api/v2/items?page=10&per_page=20&query=stocks:%3E200"
        }
        else{
            httpsString = "https://qiita.com/api/v2/tags/" + self.tag + "/items?page=1&per_page=20"
        }
        
        
        
        guard let url = URL(string:httpsString)

        else {
            print("ガード")
            return
            
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
            if let error = error{
                print("情報の取得に失敗しました:",error)
                return
            }
            if let data = data{
                do {
                    let articles = try JSONDecoder().decode([QiitaStruct].self, from: data)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                   
                    articleQiitas.append(contentsOf: articles)
                    
                }catch(let error){
                    print("情報の取得に失敗しました:",error)
                }
               
            }
           
        }
        
        task.resume()
    }

    @IBAction func tapSwift(_ sender: Any) {
        if tag == "Swift"{
            return
        }
        tag = "Swift"
        articleQiitas = []
        tableView.reloadData()
        getAPI()
    }
    @IBAction func tapPort(_ sender: Any) {
        if tag == "ポートフォリオ"{
            return
        }
        tag = "ポートフォリオ"
        articleQiitas = []
        tableView.reloadData()
        getAPI()
    }
    @IBAction func tapRxSwift(_ sender: Any) {
        if tag == "RxSwift"{
            return
        }
        tag = "RxSwift"
        articleQiitas = []
        tableView.reloadData()
        getAPI()
    }

    @IBAction func tapGo(_ sender: Any) {
        if tag == "Go"{
            return
        }
        tag = "Go"
        articleQiitas = []
        tableView.reloadData()
        getAPI()
    }
}



extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        articleQiitas.count
        return  articleQiitas.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let title = cell.viewWithTag(1) as! UILabel
        let name = cell.viewWithTag(2) as! UILabel
        title.text = articleQiitas[indexPath.row].title
        print("-----------------------------------------")
        print(articleQiitas[indexPath.row].title)
        print(articleQiitas[indexPath.row].user.name)
        name.text = articleQiitas[indexPath.row].user.name
        print("------------------------------------------")
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
      }
    
}

