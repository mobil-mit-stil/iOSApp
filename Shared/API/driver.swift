//
//  driver.swift
//  MobilMitStil
//
//  Created by Schimweg, Luca on 27/02/2021.
//

import Foundation

let API_URL: String = "https://api.mesh.kuly.cloud"

enum NetworkError: Error {
    case url
    case server
    case data
}



class DriverApi {
    var sessionId: String = ""
    init() {}
    static var shared = DriverApi()
    public func startDrive(config: RideConfig) -> Result<Void, NetworkError> {
        guard let url = URL(string: API_URL + "/driver/start") else {
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
        
        URLSession.shared.dataTask(with: req) { (data, _, error) in
            do {
                print(String(data: data!, encoding:.utf8
                ))
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
    
    public func getInformation() -> Result<[DriverInformation], NetworkError> {
        guard let url = URL(string: API_URL + "/driver/information") else {
            return .failure(.url)
        }
        
        let req = self.buildRequest(url: url)
        
        var result: Result<[DriverInformation], NetworkError>!
        
        let semaphore = DispatchSemaphore(value: 0)
        
        URLSession.shared.dataTask(with: req) { (data, _, _) in
            do {
                if let data = data {
                    result = .success(try JSONDecoder().decode([DriverInformation].self, from: data))
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
    
    public func postEstimations(estimations: [Estimation]) -> Result<Void, NetworkError> {
        guard let url = URL(string: API_URL + "/driver/estimations") else {
            return .failure(.url)
        }
        
        var req = self.buildRequest(url: url)
        req.httpMethod = "POST"
        do {
            req.httpBody = try JSONEncoder().encode(estimations)
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
    
    public func postLocations(locations: [Location]) -> Result<Void, NetworkError> {
        guard let url = URL(string: API_URL + "/driver/locations") else {
            return .failure(.url)
        }
        
        var req = self.buildRequest(url: url)
        req.httpMethod = "POST"
        do {
            req.httpBody = try JSONEncoder().encode(locations)
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
    
    public func postConfirmations(confirmations: [Confirmation]) -> Result<Void, NetworkError> {
        guard let url = URL(string: API_URL + "/driver/confirmations") else {
            return .failure(.url)
        }
        
        var req = self.buildRequest(url: url)
        req.httpMethod = "POST"
        do {
            req.httpBody = try JSONEncoder().encode(confirmations)
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
    
    private func buildRequest(url: URL) -> URLRequest {
        var req = URLRequest(url: url)
        req.setValue("Authorization", forHTTPHeaderField: self.sessionId)
        return req
    }
}
