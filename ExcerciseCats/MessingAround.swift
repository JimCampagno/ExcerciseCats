////
////  MessingAround.swift
////  ExcerciseCats
//
//
//import Foundation
//import Combine
//import SwiftUI
//
//
//struct NetworkToken {
//
//    private static let shared = NetworkToken()
//
//    @AppStorage("expirationString") private var expirationString: String?
//
//    private var formatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
//        return formatter
//    }
//
//    private var expirationDate: Date? {
//        guard let string = expirationString else {
//            return nil
//        }
//        let formatter = DateFormatter()
//        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
//        return formatter.date(from: string)
//    }
//
//    private init() { }
//
//    static func value() -> AnyPublisher<String, RequestError> {
//        guard let expiration = shared.expirationDate, expiration <= Date() else {
//            return Fail(error: RequestError.expiredToken).eraseToAnyPublisher()
//        }
//        return Result.Publisher("ABCDEFG").eraseToAnyPublisher()
//    }
//
//}
//
//
//enum RequestType {
//
//    case get
//    case post // submit
//    case put // replace
//    case delete
//
//}
//
//enum RequestError: Error {
//
//    case expiredToken
//
//}
//
//enum Request {
//
//    case allCats
//
//
//    private static let baseURL: URL = URL(string: "https://www.google.com")!
//
//    private var requiresAuth: Bool {
//        switch self {
//        case .allCats:
//            return false
//        }
//    }
//
//    private var cachePolicy: URLRequest.CachePolicy {
//            return .reloadIgnoringLocalCacheData
//    }
//
//    private var timeoutInterval: TimeInterval {
//        return 15
//    }
//
//    private var url: URL {
//        return Request.baseURL
//    }
//
//    private var headers: [String: String] {
//        switch self {
//        case .allCats:
//            return [:]
//        }
//    }
//
//    func urlRequest() -> AnyPublisher<URLRequest, RequestError> {
//        var request = URLRequest(url: url,
//                                 cachePolicy: cachePolicy,
//                                 timeoutInterval: timeoutInterval)
//
//        guard requiresAuth else {
//            return Result.Publisher.init(request).eraseToAnyPublisher()
//        }
//
//        return NetworkToken
//            .value()
//            .map { string in -> AnyPublisher<URLRequest, RequestError>
//                request.addValue(string, forHTTPHeaderField: "Authorization")
//                return Result.Publisher(request).eraseToAnyPublisher()
//            }
//
//
//    }
//
//
//
//
//
//}
//
//
////extension URLRequest {
////
////    func publisher<T: Decodable>(
////
////
////}
