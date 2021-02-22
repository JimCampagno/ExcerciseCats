//  NetworkingLayer.swift


import Foundation
import Combine



extension URLSession {

    func publisher<T: Decodable>(url: URL,
                                 decoder: JSONDecoder = .init()) -> AnyPublisher<T, Error> {
        return dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: NetworkResponse<T>.self, decoder: decoder)
            .map(\.result)
            .eraseToAnyPublisher()
    }

}

enum HTTPMethod {

    case get, put

}

enum EndPoint {

    case cats

    var httpMethod: HTTPMethod {
        switch self {
        case .cats:
            return .get
        }
    }

    var url: URL {
        switch self {
        case .cats:
            return URL(string: "https://api.mocki.io/v1/0d68799f")!
        }
    }

}

struct APIClient {

    private let urlSession = URLSession.shared

    func request<T: Decodable>(endpoint: EndPoint) -> AnyPublisher<T, Error> {
        urlSession.publisher(url: endpoint.url)
    }
    
}


final class ServiceProvider {

    lazy var catProvider: CatProvider = { CatProvider() }()

    struct CatProvider {

        private let apiClient = APIClient()

        func getCats() -> AnyPublisher<Cat, Error> {
            apiClient.request(endpoint: .cats)
        }

    }

}



struct Cat: Identifiable, Codable {

    let id: UUID
    let name: String
    let type: String

}


struct NetworkResponse<T: Decodable>: Decodable {

    var result: T

}
