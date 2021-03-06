//
//  GCService.swift
//  GoodCoffee
//
//  Created by Juan Francisco Dorado Torres on 25/08/20.
//  Copyright © 2020 Juan Francisco Dorado Torres. All rights reserved.
//

import Foundation

enum GCError: String, Error {
  case unableToComplete = "Unable to complete your request. Please check your internet connection."
  case invalidResponse = "Invalid response from the server. Please try again."
  case invalidData = "The data received from the server was invalid. Please try again."
  case unableToDecode = "The data received is unable to decode, please check the models match!"
}

struct Resource<T: Codable> {

  let url: URL
  var method: HTTPMethod = .get
  var body: Data?
}

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
}

class GCService {

  func load<T>(resource: Resource<T>, completion: @escaping (Result<T, GCError>) -> Void) {
    var request = URLRequest(url: resource.url)
    request.httpMethod = resource.method.rawValue
    request.httpBody = resource.body
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard error == nil else {
        completion(.failure(.unableToComplete))
        return
      }

      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        completion(.failure(.invalidResponse))
        return
      }

      guard let data = data else {
        completion(.failure(.invalidData))
        return
      }

      do {
        let result = try JSONDecoder().decode(T.self, from: data)
        completion(.success(result))
      } catch {
        completion(.failure(.unableToDecode))
      }
    }.resume()
  }
}
