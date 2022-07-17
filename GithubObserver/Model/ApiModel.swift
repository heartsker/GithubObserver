//
//  ApiModel.swift
//  GithubObserver
//
//  Created by Daniel Pustotin on 15.07.2022.
//

import Foundation

import Alamofire

class ApiModel {

    static var shared: ApiModel = ApiModel()

    private init() {

    }

    func userInfo(login: String, completion: @escaping (UserInfo) -> Void) {

        let url = "https://api.github.com/users/\(login)"
        AF.request(url).responseJSON(completionHandler: { response in
            if let dict = response.value as? [String : Any] {
                let info = UserInfo()
                info.login = dict["login"] as! String
                info.avatar_url = dict["avatar_url"] as? String ?? ""
                info.name = dict["name"] as? String ?? "No name"
                info.company = dict["company"] as? String ?? ""


                info.blog = dict["blog"] as? String ?? "No blog"
                info.location = dict["location"] as? String ?? "No location"

                info.email = dict["email"] as? String ?? "No email"

                info.bio = dict["bio"] as? String ?? "No bio"

                info.public_repos = dict["public_repos"] as! Int

                info.following = dict["following"] as! Int
                info.followers = dict["followers"] as! Int

                DispatchQueue.main.async {
                    completion(info)
                }
            }
        })
    }
    
    func usersList(pattern: String, completion: @escaping ([User]) -> Void) {

        var result: [User] = []

        let url = "https://api.github.com/search/users?q=\(pattern)%20in%3Auser"
        AF.request(url).responseJSON(completionHandler: { response in
            if let data = response.value as? [String : Any],
               let jsonDict = data["items"] as? [NSDictionary] {
                for item in jsonDict {
                    let user = User()
                    user.login = item["login"] as! String
                    user.url = item["html_url"] as! String

                    result.append(user)
                }
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        })
    }

    private func buildRequest(url: String) -> URLRequest? {
        let url = URL(string: url)

        guard let url = url else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }

    private func executeRequest<T: Decodable>(_ request: URLRequest,
                                              completion: @escaping (Result<T, Error>?) -> Void) {

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            var completeResult: Result<T, Error>?

            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }

            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completeResult = .success(result)
            } catch {
                completeResult = .failure(error)
            }
            
            DispatchQueue.main.async {
                guard let completeResult = completeResult else {
                    fatalError("Something is wrong, no result!")
                }
                completion(completeResult)
            }
        }
        task.resume()
    }
}
