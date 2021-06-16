//
//  This software and associated documentation files are restricted to be used,
//  reproduced, distributed, copied, modified, merged, published, sublicensed,
//  and/or sold by authorized staff. Should you find yourself is unauthorized,
//  please do not use this software in any conditions, or you may proceed to inform
//  the authorized staff to obtain an access.
//
//  This project and source code may use libraries or frameworks that are released
//  under various Open-Source license. Use of those libraries and frameworks are
//  governed by their own individual licenses.
//
//  The use of this project and source code follows the guideline as described and
//  explained on **confluence**. Please always refer to the given link to follow
//  the guideline.
//
//  viper-sandbox
//  ApiManager.swift
//
//  Created by Muhammad Faruuq Qayyum on 12/06/21.
//  Copyright (c) 2021 NewOMO. All rights reserved.
//  

import Foundation
import RxAlamofire
import RxSwift
import RxCocoa

enum ErrorHandler: Error {
    case invalidLink
    case invalidParsing
}


class ApiManager {
    
    private let disposeBag = DisposeBag()
    private let endpoint: String
    
    init(withEndpoint endpoint: String) {
        self.endpoint = endpoint
    }
    
    func getData<T: Decodable>() -> Observable<T> {
        guard let baseURL = URL(string: endpoint) else { return Observable.error(ErrorHandler.invalidLink) }
        return Observable.create { observers in
            request(.get, baseURL)
                .flatMap {
                    $0.validate(statusCode: 200...299)
                        .validate(contentType: ["application/json"])
                        .rx.data()
                }
                .observe(on: MainScheduler.instance)
                .decode(type: T.self, decoder: JSONDecoder())
                .subscribe { result in
                    observers.onNext(result)
                } onError: { err in
                    print(err.localizedDescription)
                    observers.onError(ErrorHandler.invalidParsing)
                }
        }
        
    }
    
}

/*
 private func testingRxAlamofire3() {
     let stringURL = "https://thesimpsonsquoteapi.glitch.me/quotes?count=10"
     let baseUrl = URL(string: stringURL)!
     let url = URLRequest(url: baseUrl)
     
     request(.get, baseUrl)
         .flatMap { request in
             request.validate(statusCode: 200...299)
                 .validate(contentType: ["application/json"])
                 .rx.data()
         }
         .observe(on: MainScheduler.instance)
         .decode(type: [QuoteList].self, decoder: JSONDecoder())
         .subscribe { print($0.first) }
 }
 */
