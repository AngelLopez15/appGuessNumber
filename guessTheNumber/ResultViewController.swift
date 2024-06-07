//
//  ResultViewController.swift
//  guessTheNumber
//
//  Created by Angel Octavio Lopez Cruz on 07/06/24.
//

import UIKit

class ResultViewController: UIViewController, UICollectionViewDataSource {
    @IBOutlet weak var otherNumberLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var randomNumber: Int = 0
    var guesses: [Int] = []
    weak var delegate: GameRestartDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberLabel.text = "\(randomNumber)"
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guesses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCollection", for: indexPath)
        let guess = guesses[indexPath.row]
        cell.contentView.backgroundColor = guess == randomNumber ? UIColor.green : UIColor.lightGray
        return cell
    }
    
    @IBAction func playAgainButtonTapped(_ sender: UIButton) {
        delegate?.didRequestGameRestart()
        self.dismiss(animated: true, completion: nil)
    }
}

