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
//  QuoteDetailView.swift
//
//  Created by Muhammad Faruuq Qayyum on 12/06/21.
//  Copyright (c) 2021 NewOMO. All rights reserved.
//  

import UIKit
import RxSwift
import SDWebImage

class QuoteDetailView: UIViewController {
    
    @IBOutlet weak var simpsonImage: UIImageView!
    @IBOutlet weak var quote: UILabel!
    
    private var presenter: QuoteDetailPresenter?
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContent()
    }
    
    public static func instance(withPresenter presenter: QuoteDetailPresenter) -> QuoteDetailView {
        let quoteDetailIdentifier = "QuoteDetailView"
        let storyboard = UIStoryboard(name: "QuoteDetail", bundle: nil)
        guard let detailView = storyboard.instantiateViewController(withIdentifier: quoteDetailIdentifier) as? QuoteDetailView else { fatalError("unable to load storyboard")
        }
        detailView.presenter = presenter
        return detailView
    }
    
}

extension QuoteDetailView {
    
    func loadContent() {
        presenter?.quoteDetail
            .subscribe(onNext: { item in
                self.simpsonImage.sd_setImage(with: URL(string: item.image)!, completed: nil)
                self.quote.text = item.quote
            })

            .disposed(by: bag)
    }
}
