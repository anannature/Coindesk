import UIKit

class CoindeskViewController: UIViewController {
  
  @IBOutlet var usbLabel: UILabel!
  @IBOutlet var usbRateLabel: UILabel!
  @IBOutlet var gbpLabel: UILabel!
  @IBOutlet var gbpRateLabel: UILabel!
  @IBOutlet var eurLabel: UILabel!
  @IBOutlet var eurRateLabel: UILabel!
  @IBOutlet var backgroundView: UIView!

  @IBOutlet var segmentControlCoin: UISegmentedControl!
  @IBOutlet var btcRateLabel: UILabel!
  @IBOutlet var tapActionView: UIView!
  @IBOutlet weak var coinText: UITextField!
  
  var viewModel: CoindeskViewModel?
  var nameCoin:[String] = []
  var nameRate:[String] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUp()
    setupView()
  }
  
  func setUp() {
    viewModel = CoindeskViewModel()
    viewModel?.delegate = self
    viewModel?.segmented = segmentControlCoin
    viewModel?.getCurrency()
    viewModel?.failureHandler = failureHandler
  }
  
  func setupView() {
    backgroundView.layer.cornerRadius = 24
    backgroundView.layer.shadowColor = UIColor.black.cgColor
    backgroundView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    segmentControlCoin.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
    segmentControlCoin.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    
    let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.tapAction (_:)))
    tapActionView.addGestureRecognizer(gesture)
  }
  
  @objc func tapAction(_ sender:UITapGestureRecognizer){
    let coin = ((coinText.text ?? "0.0") as String).floatValue
    viewModel?.calculateCurrencyConversion(coin: coin)
    UIView.animate(withDuration: 0.1,
                   animations: {
                    self.tapActionView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                   },
                   completion: { _ in
                    UIView.animate(withDuration: 0.1) {
                      self.tapActionView.transform = CGAffineTransform.identity
                    }
                   })
  }
  
  func failureHandler() {
    print("Error calling API.")
  }
  
  
  @IBSegueAction func gotoListView(_ coder: NSCoder) -> ListViewController? {
    UserDefaults.standard.set(nameCoin, forKey: "ArrayCoinName")
    UserDefaults.standard.set(nameRate, forKey: "ArrayCoinRate")
    
    viewModel?.stopTimer()
    return ListViewController(coder: coder)
  }
  
  @IBAction func segmentControlCoinAction(_ sender: Any) {
    //Action
  }
  
  
}

extension CoindeskViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
      let setNumber = NSCharacterSet(charactersIn:"0123456789").inverted
      let compSepByCharInSet = string.components(separatedBy: setNumber)
      let filteredNumber = compSepByCharInSet.joined(separator: "")

      return string == filteredNumber
  }
}

extension CoindeskViewController: CoindeskViewDelegate {
  func showCoindesk(coindesk: Coindesk) {
    nameCoin.append(coindesk.bpi?.USD?.code ?? "")
    nameCoin.append(coindesk.bpi?.GBP?.code ?? "")
    nameCoin.append(coindesk.bpi?.EUR?.code ?? "")
    
    nameRate.append(coindesk.bpi?.USD?.rate ?? "")
    nameRate.append(coindesk.bpi?.GBP?.rate ?? "")
    nameRate.append(coindesk.bpi?.EUR?.rate ?? "")
    
    DispatchQueue.main.async {
      self.usbLabel.text = coindesk.bpi?.USD?.code
      self.usbRateLabel.text = coindesk.bpi?.USD?.rate
      self.gbpLabel.text = coindesk.bpi?.GBP?.code
      self.gbpRateLabel.text = coindesk.bpi?.GBP?.rate
      self.eurLabel.text = coindesk.bpi?.EUR?.code
      self.eurRateLabel.text = coindesk.bpi?.EUR?.rate
    }
  }
  
  func showCoinBtc(coin: String) {
    DispatchQueue.main.async {
      self.btcRateLabel.text = coin
    }
  }
}
extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}

