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
//  SampleRx.swift
//
//  Created by Muhammad Faruuq Qayyum on 12/06/21.
//  Copyright (c) 2021 NewOMO. All rights reserved.
//  

import UIKit
import RxSwift
import RxCocoa

struct Product {
    let imageName: String
    let title: String
}

struct ProductViewModel {
    var items = PublishSubject<[Product]>()
    
    func fetchItem() {
        let products = [
            Product(imageName: "house", title: "Home"),
            Product(imageName: "gera", title: "Settings"),
            Product(imageName: "person.circle", title: "Profile"),
            Product(imageName: "airplane", title: "Flights"),
            Product(imageName: "bell", title: "Activity")
        ]
        
        items.onNext(products)
        items.onCompleted()
    }
    
}

class SampleRx: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var viewModel = ProductViewModel()
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        bindToTableData()
    }
    
    func bindToTableData() {
        //Bind items to table
        viewModel.items.bind(
            to: tableView.rx.items(
                cellIdentifier: "cell",
                cellType: UITableViewCell.self)) {
            row, item, cell in
            cell.textLabel?.text = item.title
            if #available(iOS 13.0, *) {
                cell.imageView?.image = UIImage(systemName: item.imageName)
            } else {
                cell.imageView?.image = UIImage(named: item.imageName)
            }
            
        }.disposed(by: bag)
        
        //Bind a model selected handler
        tableView.rx.modelSelected(Product.self).bind { selectedItem in
            print(selectedItem.title)
        }.disposed(by: bag)
        
        //fetch items
        viewModel.fetchItem()
    }
}

