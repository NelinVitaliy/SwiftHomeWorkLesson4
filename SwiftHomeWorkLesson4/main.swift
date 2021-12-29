//
//  main.swift
//  SwiftHomeWorkLesson4
//
//  Created by N3L1N on 29/12/2021.
//

import Foundation

class Car {
    let brand : String
    let yearOfRealease : Int
    var engine : EngineStatus = .off
    var windows : WindowsStatus = .closed
    
    enum EngineStatus:CustomStringConvertible{
        case on, off
        
        var description: String {
            switch self {
            case .on:
                return "Engine started"
            case .off:
                return "Engine stoped"
            }
        }
    }
    
    enum WindowsStatus:CustomStringConvertible {
        case opened, closed
        
        var description: String {
            switch self {
            case .opened:
                return "Windows opened"
            case .closed:
                return "Windows closed"
            }
        }
    }
        
    enum AutoBodyType:CustomStringConvertible{
        case sport, tank, refrigirator
        
        var description: String {
            switch self {
            case .sport:
                return "Sport autobody - without trunk"
            case .tank:
                return "Autobody with tank"
            case .refrigirator:
                return "Autobody with refrigirator"
                }
            }
        }
    enum Action {
        case switchEngine(EngineStatus)
        case switchWindows(WindowsStatus)
        case cargoLoad(Double)
        case additionalAutoBody(AutoBodyType)
        case replaceTypes
    }
    
    init(brand:String, yearOfRealease:Int) {
        self.brand = brand
        self.yearOfRealease = yearOfRealease
    }
    
    func perform(action:Action){}
}

class TrunkCar:Car, CustomStringConvertible{
    
    let maxCargoSpace:Double
    var currently:Double = 0
    var body:AutoBodyType?
    
    var description: String{
        _ = body?.description ?? "Separated"
        
        return "Brand:\(brand)\nYear of release:\(yearOfRealease)\n\(AutoBodyType.self) \(currently) | \(maxCargoSpace)\nStatus Car: \(EngineStatus.on) | \(WindowsStatus.closed)\n"
    }
        
    init(brand:String, yearOfRelease:Int,
         maxCargoSpace:Double, body:AutoBodyType?)
        {
            self.body = body
            self.maxCargoSpace = maxCargoSpace
            super.init(brand: brand, yearOfRealease: yearOfRelease)
        }
    
    override func perform(action:Action) {
        switch action {
        case .switchEngine(let status):
            engine = status
        case .switchWindows(let status):
            windows = status
        case .cargoLoad(let load):
            guard body != nil else {
                return
            }
            let expectedLoad =  load + currently
            switch expectedLoad {
            case _ where expectedLoad > maxCargoSpace:
                currently = maxCargoSpace
            case _ where expectedLoad < 0:
                currently = 0
            default:
                currently += load
            }
        case .additionalAutoBody(let newBody):
            self.body = newBody
            currently = 0
        default:
            break
            }
    }
}

class SportCar: Car, CustomStringConvertible {
    var zeroToHundred:Double = 0.0
    var maxSpeed:Int = 0
    
    var description: String{
        return "Brand:\(brand)\nYear of relaese:\(yearOfRealease)\nAcceleration: \(zeroToHundred)\nMax speed: \(maxSpeed)km/h \nStatus Car: \(EngineStatus.on)| \(WindowsStatus.opened)\n"
    }
    
    init(brand:String, yearOfRealease: Int,
         zeroToHundred:Double, maxSpeed:Int) {
        self.zeroToHundred = zeroToHundred
        self.maxSpeed = maxSpeed
        super.init(brand: brand, yearOfRealease: yearOfRealease)
    }
    
    override func perform(action:Action){
        switch action {
        case .switchEngine(let status):
            engine = status
        case .switchWindows(let status):
            windows = status
        case .replaceTypes:
            print("Type Replacement")
        default:
            break
        }
    }
}


var volvoTruck = TrunkCar(brand: "Volvo", yearOfRelease: 2012, maxCargoSpace: 2000, body: nil)
volvoTruck.perform(action: .additionalAutoBody(.tank))
volvoTruck.perform(action: .cargoLoad(1500))
volvoTruck.perform(action: .switchEngine(.off))
volvoTruck.perform(action: .switchWindows(.opened))
print(volvoTruck.self)

var masseratiCar = SportCar(brand: "Masserati", yearOfRealease: 2020, zeroToHundred: 2.8, maxSpeed: 380)
masseratiCar.perform(action: .switchWindows(.opened))
masseratiCar.perform(action: .replaceTypes)
masseratiCar.perform(action: .switchEngine(.on))
print(masseratiCar)
