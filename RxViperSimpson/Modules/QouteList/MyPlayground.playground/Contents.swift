import UIKit
import RxAlamofire

let baseUrl = URL(string: "https://thesimpsonsquoteapi.glitch.me/quotes?count=10")!
let url = URLRequest(url: baseUrl)

let session = URLSession.shared

let result = request(.get, url)
    .flatMap { request -> Observable<(Data?, RxProgress)> in
        let dataPart = request.rx
            .data()
            .map { d -> Data? in d }
            .startWith(nil as Data?)
        let progressPart = request.rx.progress()
        return Observable.combineLatest(dataPart, progressPart) { ($0, $1) }
    }
    .observeOn(MainScheduler.instance)
    .subscribe { print($0) }

print(result)
