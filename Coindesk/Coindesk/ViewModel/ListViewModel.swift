import Foundation
import UIKit

class ListViewModel {
  
  var data = [1,2,3,4,5]
  var dataNameCoin:[String] = []
  var dataNameRate:[String] = []
  var tableView: UITableView?
  
  func getDataCoindesk() {
    let nameCoin = UserDefaults.standard.object(forKey: "ArrayCoinName")
    let nameRate = UserDefaults.standard.object(forKey: "ArrayCoinRate")
    
    for item in (nameCoin as? NSArray)! {
      dataNameCoin.append(item as! String)
    }
    for item in (nameRate as? NSArray)! {
      dataNameRate.append(item as! String)
    }
    tableView?.reloadData()
    
  }
  

}
