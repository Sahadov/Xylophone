//
//  ViewController.swift
//  Xylophone
//
//  Created by Дмитрий Волков on 29.05.2024.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    
    private let buttonTitles = ["A", "B", "C", "D", "F", "G", "E", "D"]
    private let buttonColors = [UIColor(red: 213/255, green: 62/255, blue: 79/255, alpha: 1.0),
                                UIColor(red: 211/255, green: 95/255, blue: 58/255, alpha: 1.0),
                                UIColor(red: 245/255, green: 173/255, blue: 96/255, alpha: 1.0),
                                UIColor(red: 252/255, green: 224/255, blue: 139/255, alpha: 1.0),
                                UIColor(red: 230/255, green: 245/255, blue: 152/255, alpha: 1.0),
                                UIColor(red: 171/225, green: 221/255, blue: 164/255, alpha: 1.0),
                                UIColor(red: 102/255, green: 194/255, blue: 165/255, alpha: 1.0),
                                UIColor(red: 50/255, green: 136/255, blue: 190/255, alpha: 1.0)
    ]
    private var buttonStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setConstraints()
        createButtons()
        
        
    }
    
    func playSound(_ buttonText: String) {
        guard let url = Bundle.main.url(forResource: buttonText, withExtension: "wav") else { return }
        player = try! AVAudioPlayer(contentsOf: url)
        player?.play()
    }
    
    @objc private func buttonTapped(_ sender: UIButton){
        guard let buttonText = sender.currentTitle else { return }
        playSound(buttonText)
        
    }
    
    private func createButtons(){
        
        for (index, buttonTitle) in buttonTitles.enumerated(){
            let multiplierWidth = 0.97 - (0.03 * Double(index))
            createButton(title: buttonTitle, widthMultiplier: multiplierWidth, color: buttonColors[index])
        }
    }
    
    private func createButton(title: String, widthMultiplier: Double, color: UIColor){
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        buttonStackView.addArrangedSubview(button)
        
        
        button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthMultiplier).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        button.backgroundColor = color
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 45)
        button.layer.cornerRadius = 16
    }
    
   


}

extension ViewController {
    private func setViews(){
        view.backgroundColor = .white
        view.addSubview(buttonStackView)
        buttonStackView.axis = .vertical
        buttonStackView.alignment = .center
        buttonStackView.spacing = 10
        buttonStackView.distribution = .fillEqually
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.backgroundColor = .white
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        
        ])
    }
}
