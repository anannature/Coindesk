import UIKit
import Foundation

class ListViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  var viewModel: ListViewModel?
  var cell: ListViewTableViewCell?
  
    override func viewDidLoad() {
      super.viewDidLoad()

      viewModel = ListViewModel()
      setupView()
    }
  
  func setupView() {
      registerTableView()
      viewModel?.tableView = tableView
      viewModel?.getDataCoindesk()
    
  }
  
  func registerTableView() {
    tableView.register(UINib(nibName: "ListViewTableViewCell", bundle: nil), forCellReuseIdentifier: ListViewTableViewCell.identifier)
  }
  
}

extension ListViewController:  UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ListViewTableViewCell.identifier, for: indexPath) as? ListViewTableViewCell else { return UITableViewCell() }
    
    cell.configureWith(dataNameCoin: viewModel?.dataNameCoin[indexPath.row] ?? "",
                       dataNameRate: viewModel?.dataNameRate[indexPath.row] ?? "")
    
    return cell
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel?.dataNameCoin.count ?? 0
  }
  
  
}
