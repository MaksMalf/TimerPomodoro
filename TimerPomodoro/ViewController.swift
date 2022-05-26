//
//  ViewController.swift
//  TimerPomodoro
//
//  Created by Maksim Malofeev on 26/05/2022.
//

import UIKit

class ViewController: UIViewController {

    var isWorkTime = true
    var isStarted = false

    let pomodoroLabel: UILabel = {
        let label = UILabel()
        label.text = "Pomodoro Timer"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let shapeView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle")?.withTintColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1) , renderingMode: .alwaysOriginal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "05:00"
        label.font = UIFont.boldSystemFont(ofSize: 55)
        label.textColor =  #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let timerButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "play")?.withTintColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), renderingMode: .alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setConstrains()
    }
}

extension ViewController {

    func setConstrains() {

        view.addSubview(pomodoroLabel)
        NSLayoutConstraint.activate([
            pomodoroLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            pomodoroLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        view.addSubview(shapeView)
        NSLayoutConstraint.activate([
            shapeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shapeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            shapeView.heightAnchor.constraint(equalToConstant: 320),
            shapeView.widthAnchor.constraint(equalToConstant: 320)
        ])

        shapeView.addSubview(timerLabel)
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: shapeView.topAnchor, constant: 80),
            timerLabel.centerXAnchor.constraint(equalTo: shapeView.centerXAnchor)
        ])

        shapeView.addSubview(timerButton)
        NSLayoutConstraint.activate([
            timerButton.bottomAnchor.constraint(equalTo: shapeView.bottomAnchor, constant: -70),
            timerButton.centerXAnchor.constraint(equalTo: shapeView.centerXAnchor),
            timerButton.heightAnchor.constraint(equalToConstant: 50),
            timerButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}

