//
//  HttpClient.swift
//  Neontri
//
//  Created by KOVIGROUP on 06/11/2019.
//  Copyright © 2019 KOVIGROUP. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class HttpClient {
    
    static let sharedInstance = HttpClient()
    var clientID: String = "641e5a2d3b9a71961fac"
    var clientSecret: String = "987244301b6c4bdde3e174eddfc95cc661c7c1a2"
    
    func setHeaders() -> [String:String]? {
        if UserDefaults.standard.string(forKey: "access_token") != nil {
            let headers = [
                "Authorization": "token \(UserDefaults.standard.string(forKey: "access_token")!)"
            ]
            return headers
        } else {
            return nil
        }
    }
    
    // MARK:  Authorization on GitHub
    func startOAuth2Login() {
        let authPath:String = "https://github.com/login/oauth/authorize?client_id=\(clientID)&scope=repo&state=TEST_STATE"
        if let authURL:URL = URL(string: authPath)
        {
            print(authURL)
            UIApplication.shared.open(authURL, options: [:], completionHandler: nil)
        }
    }
    
    func getUsers(query: String, successCallback: @escaping ([User]) -> (), errorCallback: @escaping (String) -> ()){
        if query == "" {
           errorCallback("Error!")
           return
        }
        Alamofire.request(Constants.URLs.usersURL + query, headers: setHeaders()).responseArray(keyPath: "items", completionHandler: { (response: DataResponse<[User]>) in
            
            guard response.response != nil else {
                errorCallback("Error!")
                return
            }
            if (response.result.isSuccess) {
                successCallback(response.result.value!)
            } else {
                errorCallback("Error!")
            }
        })
    }
    
    func getRepositories(query: String, successCallback: @escaping ([Repository]) -> (), errorCallback: @escaping (String) -> ()){
        
        if query == "" {
            errorCallback("Error!")
            return
        }
        Alamofire.request(Constants.URLs.repositoriesURL + query, headers: setHeaders()).responseArray(keyPath: "items", completionHandler: { (response: DataResponse<[Repository]>) in
            
            guard response.response != nil else {
                errorCallback("Error!")
                return
            }
            if (response.result.isSuccess) {
                successCallback(response.result.value!)
            } else {
                errorCallback("Error!")
            }
        })
    }
    
    func getUserDetails(userURL: String, successCallback: @escaping (User) -> (), errorCallback: @escaping (String) -> ()){
        
        if userURL == "" {
            errorCallback("Error!")
            return
        }
        Alamofire.request(userURL, headers: setHeaders()).responseObject { (response: DataResponse<User>) in
            
            guard response.response != nil else {
                errorCallback("Error!")
                return
            }
            if (response.result.isSuccess) {
                successCallback(response.result.value!)
            } else {
                errorCallback("Error!")
            }
        }
    }
    
    func getUserStarts(starredURL: String, successCallback: @escaping (Int) -> (), errorCallback: @escaping (String) -> ()){
        
        if starredURL == "" {
            errorCallback("Error!")
            return
        }
        let paginatedStarredURL = starredURL + "?per_page=1&page=1"
        
        Alamofire.request(paginatedStarredURL, headers: setHeaders()).responseArray(completionHandler: { (response: DataResponse<[Starred]>) in
            
            guard response.response != nil else {
                errorCallback("Error!")
                return
            }
            
            if let linkHeader = response.response?.allHeaderFields["Link"] as? String {
                
                let regex = try! NSRegularExpression(pattern: "[\\?\\&]page=(?<page>\\d+)>; rel=\"last\"")
                let match = regex.firstMatch(in: linkHeader, range: NSMakeRange(0, linkHeader.count))!
                
                let nsString = linkHeader as NSString
                if let lastPage = Int(nsString.substring(with: match.range(withName: "page"))) {
                    successCallback(lastPage)
                }
                errorCallback("Error!")
            } else {
                errorCallback("Error!")
            }
        })
    }
    
    //MARK: Access token from GitHub
    func processOAuthStep1Response(url: NSURL)
    {
        let components = NSURLComponents(url: url as URL, resolvingAgainstBaseURL: false)
        var code:String?
        if let queryItems = components?.queryItems
        {
            for queryItem in queryItems
            {
                if (queryItem.name.lowercased() == "code")
                {
                    code = queryItem.value
                    break
                }
            }
        }
        if let receivedCode = code {
            print("receivedCode\(receivedCode)")
            let getTokenPath:String = "https://github.com/login/oauth/access_token"
            let tokenParams = ["client_id": clientID, "client_secret": clientSecret, "code": receivedCode]
            Alamofire.request(getTokenPath, method: .post, parameters: tokenParams).responseString(completionHandler: { (response) in
                if let anError = response.error
                {
                    print(anError)
                    UserDefaults.standard.removeObject(forKey: "access_token")
                }
                let results = response.result.value
                if let receivedResults = results
                {
                    let resultParams = receivedResults.split(separator: "&")
                    let resultsSplit = resultParams[0].split(separator: "=")
                    
                    UserDefaults.standard.set(resultsSplit[1], forKey: "access_token")
                }
            })
        }
    }
}
