//
//  ViewController.swift
//  ExcerciseCats
//
//  Created by Jim Campagno on 2/21/21.
//

import UIKit
import Combine

class ViewController: UIViewController {

    let serviceProvider = ServiceProvider()
    var subscriptions = Set<AnyCancellable>()


    override func viewDidLoad() {
        super.viewDidLoad()

        serviceProvider.catProvider.getCats()
            .subscribe(on: DispatchQueue.main)
            .sink { success in
                print(success)
            } receiveValue: { cat in
                print(cat)
            }
            .store(in: &subscriptions)

        // Do any additional setup after loading the view.
    }


}

