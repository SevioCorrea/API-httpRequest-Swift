//
//  ViewController.swift
//  httpRequest
//
//  Created by Sévio on 24/09/22.
//

import UIKit

struct Post: Codable { // Codable para traduzir os parâmetros do Objeto.
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        makeRequest { (posts) in // Quando terminar a chamada, vai cair aqui. Pois é uma chamada assíncrona.
            // A chamada pode demorar.
            print("objects posts: \(posts[0].title)") // MARK - Manipulando
        }
    }
    
    
    // MARK - Get na URL
    private func makeRequest(completion: @escaping ([Post]) -> ()) { //É um retorno.
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            // data é um objeto em Bytes. // response tem as informações do Header dessa chamada.
            // error é para mostrar se tiver algum erro durante a chamada.
            
            //print("response: \(String(describing: response))")
            //print("error: \(String(describing: error))")
            
            
            // MARK - Lendo os dados
            guard let responseData = data else { return }
            
            
            do {
                let posts = try JSONDecoder().decode([Post].self, from: responseData)
                //print("objects posts: \(posts)")
                completion(posts)
                
            } catch let error {
                print("error: \(error)")
            }
            
        }
        task.resume()
    }


}
