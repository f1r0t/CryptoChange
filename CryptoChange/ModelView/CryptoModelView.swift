//
//  CryptoModelView.swift
//  CryptoChange
//
//  Created by Fırat AKBULUT on 27.10.2023.
//

import Foundation
import RxSwift
import RxCocoa

class CryptoModelView {
    
    let cryptos:  PublishSubject<[Crypto]> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    let loading: PublishSubject<Bool> = PublishSubject()
    
    func requestData(){
        
        loading.onNext(true)
        
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        WebService().downloadCurrencies(url: url) { result in
            
            self.loading.onNext(false)
            
            switch result {
            case .success(let cryptos):
                self.cryptos.onNext(cryptos)
            case .failure(let error):
                
                switch error {
                case .parsingError:
                    self.error.onNext("Parsing Error")
                case .serverError:
                    self.error.onNext("Server Error")
                }
      
            }
        }
    }
}
