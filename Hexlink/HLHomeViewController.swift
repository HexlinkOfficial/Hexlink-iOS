//
//  HLHomeViewController.swift
//  Hexlink
//
//  Created by Yang Xi on 10/30/22.
//

import Foundation
import UIKit

struct ErrorData : Codable {
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}

struct NotificationObject : Codable {
    var address: String
    var notifiToken: String

    enum CodingKeys: String, CodingKey {
        case address
        case notifiToken
    }
}

class HLHomeViewController: UIViewController, HLHomeViewDelegate {
  
    private var homeView: HLHomeView = HLHomeView()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        homeView.delegate = self
        homeView.frame = self.view.frame
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(homeView)
    }
    
    func homeViewSendButtonTapped() {
        print("Add button tapped")
        self.present(UINavigationController(rootViewController: HLQRCodeScannerViewController()), animated: true)
    }
    
    func homeViewSetupButtonTapped() {
        print("Setup button tapped")
        
        Task {
            do {
                try await sendRequest()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func sendRequest() async throws {
        let url = URL(string: "http://localhost:8017/auth-app/setup")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let encodedAddress = try? JSONEncoder().encode(NotificationObject(address: "0x1234", notifiToken: "abc")) else {
            return
        }
        
        let (data, response) = try await URLSession.shared.upload(for: urlRequest, from: encodedAddress)
        print("sent");

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print("error");
            print(response);
            print(data);
            let errorData = try JSONDecoder().decode(ErrorData.self, from: data).message
            print("Error \(errorData)")
            throw URLError(.cannotParseResponse)
        }
        print("no error");
        print(data);
        let jsonData =  try JSONDecoder().decode(NotificationObject.self, from: data)
        print(jsonData.address)
    }
}
