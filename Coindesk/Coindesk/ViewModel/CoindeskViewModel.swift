import Foundation
import UIKit

//REMARK: เนื่องจาก API ไม่มีค่าของ BTC จึงให้ค่า BTC ตรงตามวันที่ 20/04/2023 (BTC หน่วยเป็นบาท)
protocol CoindeskViewDelegate: AnyObject {
  func showCoindesk(coindesk: Coindesk)
  func showCoinBtc(coin: String)
}

class CoindeskViewModel {
  var delegate: CoindeskViewDelegate?
  var failureHandler: (() -> Void)?
  var ticker: Timer?
  var segmented: UISegmentedControl?
  let btc: Float = 1008971.15
  var data: Coindesk?

  func getCurrency() {
    setTimer()
    let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json")!
    URLSession.shared.fetchData(at: url) { (result: Result<Coindesk, Error>) in
        switch result {
        case .success(let response):
          self.delegate?.showCoindesk(coindesk: response)
          self.data = response
        case .failure(_ ):
          self.failureHandler?()
      }
    }
  }
  
  func calculateCurrencyConversion(coin: Float) {
    switch segmented?.selectedSegmentIndex {
            case 0:
      let coinConversion = ((data?.bpi?.USD?.rate_float ?? 0.0) * coin) / btc
              delegate?.showCoinBtc(coin: String(coinConversion))
            case 1 :
      let coinConversion = ((data?.bpi?.GBP?.rate_float ?? 0.0) * coin) / btc
              delegate?.showCoinBtc(coin: String(coinConversion))
            case 2:
      let coinConversion = (data?.bpi?.EUR?.rate_float ?? 0.0 * coin) / btc
              delegate?.showCoinBtc(coin: String(coinConversion))
            default:
                break
            }
  }
  
  
  func setTimer() {
    ticker  = Timer.scheduledTimer(
      timeInterval: 60,
      target: self,
      selector: #selector(getCurrencyAgain),
      userInfo: nil,
      repeats: true)
  }
  
  @objc func getCurrencyAgain() {
    getCurrency()
  }
  
  func stopTimer() {
    ticker?.invalidate()
  }
}
