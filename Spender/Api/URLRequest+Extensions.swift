//
//  URLRequest+Extensions.swift
//  Spender
//
//  Created by Len van Zyl on 2021/07/21.
//

import Foundation
import RxSwift
import RxCocoa

struct Resource<T: Decodable> {
    let url: URL
}

extension URLRequest {
    static func load<T>(resource: Resource<T>, parameters: [String: Any]?) -> Observable<T> {
        return Observable.just(resource.url)
            .flatMap { url -> Observable<Data> in
            var request = URLRequest(url: url)
            if let requestParameters = parameters {
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: requestParameters, options: .prettyPrinted)
                } catch let error {
                    fatalError(error.localizedDescription)
                }
            }
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            return URLSession.shared.rx.data(request: request)
        }.map { data -> T in
            let response = try JSONDecoder().decode(T.self,from: data)
            return response
        }
    }
}

extension Purchases {
    static var all: Resource<Purchases> = {
        let url = URL(string: Commons.baseApiUrl + "")!
        return Resource(url: url)
    }()
}
