//
//  passenger.swift
//  MobilMitStil
//
//  Created by Schimweg, Luca on 27/02/2021.
//

import Foundation

class PassengerApi {
    var sessionId: String = ""
    
    init() { }
    
    func postStart(config: PassengerRequest) -> Result<Void, NetworkError> {
        guard let url = URL(string: API_URL + "/passenger/start") else {
            return .failure(.url)
        }
        
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        do {
            req.httpBody = try JSONEncoder().encode(config)
        } catch {
            return .failure(.data)
        }
        
        
        var result: Result<Void, NetworkError>!
        
        let semaphore = DispatchSemaphore(value: 0)
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            do {
                if let data = data {
                    let decoded = try JSONDecoder().decode(SessionResponse.self, from: data)
                    self.sessionId = decoded.sessionId
                    result = .success(Void())
                } else {
                    result = .failure(.server)
                }
            } catch {
                result = .failure(.server)
            }
            semaphore.signal()
        }.resume()

        _ = semaphore.wait(wallTimeout: .distantFuture)
        return result
    }
    
    func getInformation() -> Result<[PassengerInformation], NetworkError> {
        guard let url = URL(string: API_URL + "/passenger/information") else {
            return .failure(.url)
        }
        
        let req = self.buildRequest(url: url)
        
        var result: Result<[PassengerInformation], NetworkError>!
        
        let semaphore = DispatchSemaphore(value: 0)
        
        URLSession.shared.dataTask(with: req) { (data, _, _) in
            do {
                if let data = data {
                    result = .success(try JSONDecoder().decode([PassengerInformation].self, from: data))
                } else {
                    result = .failure(.server)
                }
            } catch {
                result = .failure(.server)
            }
            semaphore.signal()
        }.resume()

        _ = semaphore.wait(wallTimeout: .distantFuture)
        return result
    }
    
    func postLocation(location: Location) -> Result<Void, NetworkError> {
        guard let url = URL(string: API_URL + "/passenger/location") else {
            return .failure(.url)
        }
        
        var req = self.buildRequest(url: url)
        req.httpMethod = "POST"
        do {
            req.httpBody = try JSONEncoder().encode(location)
        } catch {
            return .failure(.data)
        }
        
        var result: Result<Void, NetworkError>!
        
        let semaphore = DispatchSemaphore(value: 0)
        
        URLSession.shared.dataTask(with: req) { (data, _, _) in
            if data != nil {
                result = .success(Void())
            } else {
                result = .failure(.server)
            }
            semaphore.signal()
        }.resume()

        _ = semaphore.wait(wallTimeout: .distantFuture)
        return result
    }
    
    func postRequest(driverId: Uuid) -> Result<Bool, NetworkError> {
        let requestData = PassengerBookRequest(driverId: driverId)
        guard let url = URL(string: API_URL + "/passenger/request") else {
            return .failure(.url)
        }
        
        var req = self.buildRequest(url: url)
        req.httpMethod = "POST"
        do {
            req.httpBody = try JSONEncoder().encode(requestData)
        } catch {
            return .failure(.data)
        }
        
        var result: Result<Bool, NetworkError>!
        
        let semaphore = DispatchSemaphore(value: 0)
        
        URLSession.shared.dataTask(with: req) { (data, _, _) in
            if data != nil {
                result = .success(true)
            } else {
                result = .success(false)
            }
            semaphore.signal()
        }.resume()

        _ = semaphore.wait(wallTimeout: .distantFuture)
        return result
    }
    
    private func buildRequest(url: URL) -> URLRequest {
        var req = URLRequest(url: url)
        req.setValue("Authorization", forHTTPHeaderField: self.sessionId)
        return req
    }
}
