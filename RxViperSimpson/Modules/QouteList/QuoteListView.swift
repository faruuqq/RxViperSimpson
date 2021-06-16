//
//  ViewController.swift
//  viper-sandbox
//
//  Created by Muhammad Faruuq Qayyum on 20/05/21.
//

import UIKit
import RxAlamofire
import RxSwift
import RxCocoa

class QuoteListView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var presenter: QuoteListPresenter?
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindToTableData()
        tableCellSelectedHandler()
        self.title = "Simpson Quotes"
    }
    
    // MARK: - Public Function
    public static func instance(withPresenter presenter: QuoteListPresenter) -> QuoteListView {
        let quoteListIdentifier = "QuoteListView"
        let storyboard = UIStoryboard(name: quoteListIdentifier, bundle: nil)
        guard let quoteListView = storyboard.instantiateViewController(withIdentifier: quoteListIdentifier) as? QuoteListView else { fatalError() }
        quoteListView.presenter = presenter
        return quoteListView
    }

}

// MARK: - Functions
extension QuoteListView {
    
    private func bindToTableData() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        presenter?.intialcontentLoad()
        presenter?.quoteLists.bind(
            to: tableView.rx.items(
                cellIdentifier: "cell",
                cellType: UITableViewCell.self)) {
            row, item, cell in
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = item.quote
        }.disposed(by: bag)
    }
    
    private func tableCellSelectedHandler() {
        tableView.rx.modelSelected(QuoteListEntity.self).bind { [weak self] item in
            guard let self = self else { return }
            if let indexPath = self.tableView.indexPathForSelectedRow {
                self.tableView.deselectRow(at: indexPath, animated: true)
            }
//            print(item)
            let quoteDetail = QuoteDetailEntity(
                quote: item.quote,
                image: item.image)
            self.presenter?.navigateToQuoteDetail(using: self.navigationController!, with: quoteDetail)
        }.disposed(by: bag)
    }
    
}

/*
 private func testingRxAlamofire() {
     let stringURL = "https://thesimpsonsquoteapi.glitch.me/quotes?count=10"
     let baseUrl = URL(string: stringURL)!
     let url = URLRequest(url: baseUrl)
     
     RxAlamofire.requestJSON(.get, baseUrl)
         .subscribe { (_, result) in
             if let result = result as? [[String: Any]] {
                 print(result.first!["character"] as! String)
             }
         } onError: { err in
             print(err)
         }
         .disposed(by: disposeBag)
 }
 
 private func testingRxAlamofire2() {
     let stringURL = "https://thesimpsonsquoteapi.glitch.me/quotes?count=10"
     let baseUrl = URL(string: stringURL)!
     let url = URLRequest(url: baseUrl)
     
     RxAlamofire.data(.get, baseUrl)
         .decode(type: [QuoteList].self, decoder: JSONDecoder())
         .subscribe { res in
             print(res.first)
         } onError: { err in
             print(err)
         }
         .disposed(by: disposeBag)
 }
 
 private func testingRxAlamofire3() {
     let apiManager = ApiManager(withEndpoint: "https://thesimpsonsquoteapi.glitch.me/quotes?count=3")
     apiManager.getData()
         .subscribe { (result: [QuoteList]) in
             print(result)
         } onError: { err in
             print(err)
         } onCompleted: {
             print("main completed")
         } onDisposed: {
             print("main dispose")
         }
         .disposed(by: disposeBag)

 }
 
 private func testingRxCocoa() {
     let stringURL = "https://thesimpsonsquoteapi.glitch.me/quotes?count=10"
     let baseUrl = URL(string: stringURL)!
     let url = URLRequest(url: baseUrl)

     URLSession.shared.rx.data(request: url)
         .decode(type: [QuoteList].self, decoder: JSONDecoder())
         .subscribe { res in
             print(res.first)
         }
         .disposed(by: disposeBag)
 }
 */
