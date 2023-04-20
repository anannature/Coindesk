import Foundation

//ปกติแล้ว Service ที่ set path, method, parameters จะอยู่ในไฟล์นี้
extension URLSession {
  func fetchData(at url: URL, completion: @escaping (Result<Coindesk, Error>) -> Void) {
    self.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completion(.failure(error))
      }

      if let data = data {
        do {
          let jsonData = try JSONDecoder().decode(Coindesk.self, from: data)
          completion(.success(jsonData))
        } catch let decoderError {
          completion(.failure(decoderError))
        }
      }
    }.resume()
  }
}
