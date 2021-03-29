//
//  NetworkManager.swift
//  Sportable
//
//  Created by NewAgeSMB on 03/08/20.
//  Copyright © 2020 NewAgeSMB. All rights reserved.
//

import UIKit
import Alamofire

typealias Completion = (Data?, [String: Any]?, String, Bool) -> Void

enum Encoder {
    case jsonEncoding
    case urlEncoding
}

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchingResponse(from url: URL, parameters: [String: Any]?, method: HTTPMethod = .post, encoder: Encoder = .jsonEncoding, completion: @escaping Completion) {
        
        let parameterEncoder: ParameterEncoding = (encoder == .jsonEncoding ? JSONEncoding.default : URLEncoding.default)
        
        AF.request(url, method: method, parameters: parameters, encoding: parameterEncoder, headers: [:]).responseJSON { (jsonResponse) in
            debugPrint(jsonResponse)
             
            if let parseError = jsonResponse.error?.parseError() {
                completion(jsonResponse.data, nil, parseError.description, false)
                return
            }
            do {
                let result = try jsonResponse.result.get()
                let responseDictionary = result as? [String: Any]
                
                let status = responseDictionary?["status"] as? Bool ?? false
                let errMessage = responseDictionary?["message"] as? String ?? ""
                
                completion(jsonResponse.data, responseDictionary, errMessage, status)
                
            } catch {
                debugPrint(error)
                completion(nil, nil, error.localizedDescription, false)
            }
        }
        
    }
    
//    func getHeader(with isEnabled: Bool = true) -> HTTPHeaders {
//        var header: HTTPHeaders = [:]
//        guard isEnabled else { return header }
//
//        if let authToken = UserDefaults.standard.authToken {
//            header.add(name: "AuthToken", value: authToken)//auth_token
//        }
//        if let refreshToken = UserDefaults.standard.refreshToken {
//            header.add(name: "RefreshToken", value: refreshToken)//refresh_token
//        }
//        return header
//    }
//
//    private func updateTokens(with headerFields: [AnyHashable: Any]?) {
//        if let authToken = headerFields?["AuthToken"] as? String {
//            UserDefaults.standard.authToken = authToken
//        }
//        if let refreshToken = headerFields?["RefreshToken"] as? String {
//            UserDefaults.standard.refreshToken = refreshToken
//        }
//    }
}

extension AFError {
    func parseError() -> String? {
        switch self {
        case .createUploadableFailed(let error):
            debugPrint(error.asAFError?.errorDescription ?? "")
            break
        case .createURLRequestFailed(let error):
            debugPrint(error)
            break
        case .downloadedFileMoveFailed(let error, let source, let destination):
            debugPrint(error)
            debugPrint(source)
            debugPrint(destination)
            break
        case .explicitlyCancelled:
            break
        case .invalidURL(let error):
            debugPrint(error)
            break
        case .multipartEncodingFailed(let error):
            debugPrint(error)
            break
        case .parameterEncodingFailed(let error):
            debugPrint(error)
            break
        case .parameterEncoderFailed(let error):
            debugPrint(error)
            break
        case .requestAdaptationFailed(let error):
            debugPrint(error)
            break
        case .requestRetryFailed(let retryError, let originalErro):
            debugPrint(retryError)
            debugPrint(originalErro)
            break
        case .responseValidationFailed(let error):
            debugPrint(error)
            break
        case .responseSerializationFailed(let error):
            debugPrint(error)
            break
        case .serverTrustEvaluationFailed(let error):
            debugPrint(error)
            break
        case .sessionDeinitialized:
            break
        case .sessionInvalidated(let error):
            debugPrint(error ?? "")
            break
        case .sessionTaskFailed(let error):
            debugPrint(error)
            break
        case .urlRequestValidationFailed(let error):
            debugPrint(error)
            break
        }
        return self.asAFError?.errorDescription
    }
}
