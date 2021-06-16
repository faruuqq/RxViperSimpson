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
//  QuoteListRouter.swift
//
//  Created by Muhammad Faruuq Qayyum on 11/06/21.
//  Copyright (c) 2021 NewOMO. All rights reserved.
//  

import UIKit
import RxSwift

class QuoteListRouter {
    
    func initialViewController() -> QuoteListView {
        let interactor = QuoteListInteractor()
        let presenter = QuoteListPresenter(interactor: interactor)
        let view = QuoteListView.instance(withPresenter: presenter)
        return view
    }
    
    func pushToQuoteDetailView(using navigationController: UINavigationController, with data: QuoteDetailEntity) {
        let quoteDetailRouter = QuoteDetailRouter.initialViewController(with: data)
        navigationController.pushViewController(quoteDetailRouter, animated: true)
    }
}

