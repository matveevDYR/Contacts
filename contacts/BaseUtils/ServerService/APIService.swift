//
//  APIService.swift
//  contacts
//
//  Created by Денис Матвеев on 26.02.2022.
//  Copyright © 2022 SkbkonturMobile. All rights reserved.
//

import Foundation

enum requestType: String {
    case get = "GET"
    case post = "POST"
}

class APIService: ContactsServiceProtocol {
    
    private func collectRequest(url: URL, requestType: requestType, params: Data?) -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 15)
        request.httpMethod = requestType.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = params
        
        messagePrint(type: "jsonDataParameters", message: String(data: request.httpBody ?? Data(), encoding: .utf8) ?? "no body data")
        
        return request
    }
    
    private func returnError(statusCode: Int) -> String {
        var message = "Код ошибки не распознан"
        switch statusCode {
        case 001: message = "Подключение к сети отсутствует"
        case 002: message = "Не удалось загрузить данные"
        case 003: message = "Ошибка формирования модели данных"
        case 004: message = "Ссылка больше не действительна"
        case 204: message = "Контент отсутствует"
        case 400, 422: message = "Bed Request. Сервер не смог обработать запрос"
        case 404: message = "Страница не найдена"
        case 429: message = "Превышено количество запросов"
        case 500: message = "Внутренняя ошибка сервера"
        case 503: message = "Сервер не доступен, попробуйте позднее"
        case 522: message = "Превышен интервал ожидания сервера"
        default: break
        }
        self.messagePrint(type: "STATUS CODE", message: "Status Code: \(String(statusCode)) - \(message)")
        return message
    }
    
    private func messagePrint(type: String?, message: Any) {
        /*
            if let type = type {
                print("\n /// ",type," /// \n")
            } else {
                print("\n")
            }
            debugPrint(message)
            print("\n")
         */
    }
    
    
    func convertResult<T: Codable>(URLString: String, requestType: requestType, params: Data?, completion: @escaping (T?, String?) -> Void) {
        
        func sendError(statusCode: Int?) {
            guard let code = statusCode else {sendError(statusCode: 500); return}
            let error = self.returnError(statusCode: code)
            completion(nil, error)
        }
        
        guard let reachbility = Reachability(), reachbility.currentReachabilityStatus != .notReachable else {
            sendError(statusCode: 001); return}
        guard let url = URL(string: URLString) else {sendError(statusCode: 004); return}
        
        let request = self.collectRequest(url: url, requestType: requestType, params: params)
        
        self.messagePrint(type: "URL", message: url as Any)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                
                guard let response = response else {
                    var statusCode = 503
                    
                    if let error = error?.localizedDescription {
                        self.messagePrint(type: "error.localizedDescription", message: String(error))
                        if error == "The request timed out." {statusCode = 522}
                    }
                    
                    sendError(statusCode: statusCode)
                    return
                }
                
                self.messagePrint(type: "responseURL", message: response.url as Any)
                
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                guard statusCode == 200 else {sendError(statusCode: statusCode); return}
                guard let data = data else {sendError(statusCode: 002); return}
                
                let responseData = try? JSONSerialization.jsonObject(with: data, options: [])
                
                self.messagePrint(type: "responseData", message: responseData as Any)
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let model = try decoder.decode(T.self, from: data)
                    completion(model, nil)
                } catch let myDataError {
                    self.messagePrint(type: "decodeDataError", message: myDataError)
                    sendError(statusCode: 003)
                }
                
            }
        }.resume()
    }
    
    
}
