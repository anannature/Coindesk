import Foundation


struct Coindesk: Decodable {
  var time: Time?
  var disclaimer: String?
  var chartName: String?
  var bpi: Bpi?
}

struct Time: Decodable {
  var updated: String?
  var updatedISO: String?
  var updateduk: String?
}

struct Bpi: Decodable {
  var USD: BpiCurrency?
  var GBP: BpiCurrency?
  var EUR: BpiCurrency?
}

struct BpiCurrency: Decodable {
  var code: String?
  var symbol: String?
  var rate: String?
  var description: String?
  var rate_float: Float?
}
