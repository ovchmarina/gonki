//
//  ViewController.swift
//  weather
//
//  Created by user on 22/11/2020.
//
import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var currentCity: UILabel!
    @IBOutlet weak var currentCityIcon: UIImageView!
    @IBOutlet weak var currentCityTemp: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var array = ["Москва", "Екатеринбург", "Владивосток"]
    
    var arrCity = [City]()
   
override func viewDidLoad() {
        super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    
    
    
    for cityitem in array {
        setCityArray(name: cityitem)
    }
}
    override func viewWillAppear(_ animated: Bool) {
        
        getCityDetail(name: "Екатеринбург")
    }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrCity.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
            cell.nameCity.text = arrCity[indexPath.row].name
            cell.temp.text = arrCity[indexPath.row].temp
            cell.time.text = arrCity[indexPath.row].time
            cell.icon.image = UIImage(data: try! Data(contentsOf: URL(string: arrCity[indexPath.row].icon)!))
            cell.backgroundCell.image = UIImage(data: try! Data(contentsOf: URL(string: "https://upload.wikimedia.org/wikipedia/commons/4/42/Blue_sky%2C_white-gray_clouds.jpg")!))
            return cell
        }
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func getCityDetail(name: String) {
        let url = "http://api.weatherapi.com/v1/current.json?key=\(token)&q=\(name)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request(url!, method: .get).validate().responseJSON
        { (response) in
            switch response.result {
            
               case .success(let value):
                   let json = JSON(value)
                self.currentCity.text = name
                self.currentCityTemp.text = json["current"]["temp_c"].stringValue
               
              let iconString = "https:\(json["current"]["condition"]["icon"].stringValue)"
                
                self.currentCityIcon.image = UIImage(data: try! Data(contentsOf: URL(string: iconString)!))
                
                   print("JSON: \(json)")
                
               case .failure(let error):
                   print(error)
               }
    }
    }
    let token = "6acca9a3995e42808d1150557202211"
    func setCityArray(name: String) {
        let url = "http://api.weatherapi.com/v1/current.json?key=\(token)&q=\(name)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request(url!,method: .get).validate().responseJSON
        { (response) in
            switch response.result {
               case .success(let value):
                   let json = JSON(value)
                let temp = json["current"]["temp_c"].stringValue
                let icon = "https:\(json["current"]["condition"]["icon"].stringValue)"
                let time = json["location"]["localtime"].stringValue
                self .arrCity .append(City(name: name, temp: temp, time: time, icon: icon))
                self.tableView.reloadData()
               case .failure(let error):
                   print(error)
               }
        }
    }
        struct  City  {
            var name: String
            var temp: String
            var time: String
            var icon: String
                    // Do any additional setup after loading the view.
        }
}
