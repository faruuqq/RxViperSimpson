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
//  QuoteListPresenter.swift
//
//  Created by Muhammad Faruuq Qayyum on 11/06/21.
//  Copyright (c) 2021 NewOMO. All rights reserved.
//  

import UIKit
import RxSwift

class QuoteListPresenter {
    
    private let interactor: QuoteListInteractor
    private let router = QuoteListRouter()
    private let bag = DisposeBag()
    
    var quoteLists = PublishSubject<[QuoteListEntity]>()
    
    init(interactor: QuoteListInteractor) {
        self.interactor = interactor
    }
    
    func intialcontentLoad() {
        interactor.fetchQuote()
        interactor.quoteLists
            .subscribe {
                self.quoteLists.onNext($0)
            }
            .disposed(by: bag)
    }
    
    func navigateToQuoteDetail(using navigationController: UINavigationController, with data: QuoteDetailEntity) {
        router.pushToQuoteDetailView(using: navigationController, with: data)
    }
}

