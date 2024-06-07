//
//  ViewController.swift
//  guessTheNumber
//
//  Created by Angel Octavio Lopez Cruz on 07/06/24.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, GameRestartDelegate {
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var randomNumber: Int = Int.random(in: 0...20)
    var guesses: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("entro aqui")
        super.viewWillAppear(animated)
        resetGame()
    }
    
    @IBAction func guessButtonTapped(_ sender: UIButton) {
        guard let text = numberTextField.text, let guess = Int(text) else { return }
        guesses.append(guess)
        tableView.reloadData()
        
        if guess == randomNumber {
            performSegue(withIdentifier: "showResult", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.randomNumber = randomNumber
            destinationVC.guesses = guesses
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let guess = guesses[indexPath.row]
        cell.textLabel?.text = "\(guess)"
        if guess > randomNumber {
            cell.backgroundColor = UIColor.blue
        } else if guess < randomNumber {
            cell.backgroundColor = UIColor.yellow
        }
        return cell
    }
    
    func resetGame() {
        randomNumber = Int.random(in: 0...20)
        guesses.removeAll()
        tableView.reloadData()
        numberTextField.text = ""
    }
    
    func didRequestGameRestart() {
            resetGame()
        }

}


