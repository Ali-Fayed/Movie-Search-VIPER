//
//  RequsetLogger.swift
//  VIPER
//
//  Created by Ali Fayed on 01/05/2021.
//

import Foundation
import Alamofire
import UIKit

class RequestLogger: EventMonitor {
  let queue = DispatchQueue(label: "com.product.IOS14.Githubgenics.networklogger")

  func requestDidFinish(_ request: Request) {
    print(request.description)
  }

//  func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
//    guard let data = response.data else {
//      return
//    }
//
//
//    if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
//      print(json)
//    }
//
//
//  }
//
}
