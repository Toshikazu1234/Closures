//
//  ViewController.swift
//  Closures
//
//  Created by R K on 2/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    private var data: [String] = []
    private let exclamation = "!"
    
    enum CustomError: String, Error {
        case boo = "Boo it's Monday"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        data = setData()
        print(data)
        
        
        fetchData { [weak self] data in
            guard let self else { return }
            self.data = data
        }
        
        
        data = manipulateData { day in
            var day = day
            day += exclamation
            return day
        }
        print(data)
    }
    
    func setData() -> [String] {
        let data = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        return data
    }
    
    func manipulateData(_ closure: (String) -> String) -> [String] {
        var days: [String] = []
        data.forEach { str in
            let day = closure(str)
            days.append(day)
        }
        return days
    }
    
    func fetchData(_ completion: @escaping ([String]) -> Void) {
        // URLSession network call
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let data = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
            completion(data)
        }
    }
}

extension [String] {
    func mapString(closure: (String) -> String) -> [String] {
        var array: [String] = []
        for item in self {
            let str = closure(item)
            array.append(str)
        }
        return array
    }
    
    func throwableMapString(closure: (String) throws -> String) rethrows -> [String] {
        var array: [String] = []
        for item in self {
            let str = try closure(item)
            array.append(str)
        }
        return array
    }
}
