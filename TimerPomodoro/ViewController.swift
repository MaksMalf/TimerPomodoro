//
//  ViewController.swift
//  TimerPomodoro
//
//  Created by Maksim Malofeev on 26/05/2022.
//

import UIKit

class ViewController: UIViewController {

    static var isWorkTime = true
    static var isStarted = true

    static var color = UIColor.systemRed

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
        imageView.image = UIImage(systemName: "circle")?.withTintColor(.systemGray6, renderingMode: .alwaysOriginal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "25:00"
        label.font = UIFont.boldSystemFont(ofSize: 55)
        label.textColor = color
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let timerButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "play")?.withTintColor(color, renderingMode: .alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var timer = Timer()

    let shapeLayer = CAShapeLayer()

    var minutesDurationTimer = 25

    var secondsDurationTimer = 0

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        animationTimer()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setConstrains()

        timerButton.addTarget(self, action: #selector(timerButtonTapped), for: .touchUpInside)
    }

    @objc func timerButtonTapped() {

        if ViewController.isStarted {
            basicAnimation()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            ViewController.isStarted = false
            timerButton.setBackgroundImage(UIImage(systemName: "pause")?.withTintColor(ViewController.color, renderingMode: .alwaysOriginal), for: .normal)
        } else {
            timer.invalidate()
            stopAnimation()
            ViewController.isStarted = true
            timerButton.setBackgroundImage(UIImage(systemName: "play")?.withTintColor(ViewController.color, renderingMode: .alwaysOriginal), for: .normal)
        }
    }

    @objc func timerAction() {

        if secondsDurationTimer == 0 {
            secondsDurationTimer = 60
            minutesDurationTimer -= 1
        }

        secondsDurationTimer -= 1
        switch (minutesDurationTimer, secondsDurationTimer) {
        case (10..., 10...):
            timerLabel.text = "\(minutesDurationTimer):\(secondsDurationTimer)"
        case (0...10, 10...):
            timerLabel.text = "0\(minutesDurationTimer):\(secondsDurationTimer)"
        case (10..., 0...10):
            timerLabel.text = "\(minutesDurationTimer):0\(secondsDurationTimer)"
        case (0...10, 0...10):
            timerLabel.text = "0\(minutesDurationTimer):0\(secondsDurationTimer)"
        default:
            if ViewController.isWorkTime == true {
                isRest()
            } else {
                isWork()
            }
        }
    }

    //MARK: Operating modes

    private func isRest() {

        minutesDurationTimer = 5
        secondsDurationTimer = 0

        ViewController.color = UIColor.systemGreen

        timerLabel.textColor = ViewController.color

        timerButton.setBackgroundImage(UIImage(systemName: "pause")?.withTintColor(ViewController.color, renderingMode: .alwaysOriginal), for: .normal)
        ViewController.isWorkTime = false

        basicAnimation()
    }

    func isWork() {

        minutesDurationTimer = 25
        secondsDurationTimer = 0

        ViewController.color = UIColor.systemRed

        timerLabel.textColor = ViewController.color

        timerButton.setBackgroundImage(UIImage(systemName: "pause")?.withTintColor(ViewController.color, renderingMode: .alwaysOriginal), for: .normal)
        ViewController.isWorkTime = true

        basicAnimation()
    }

    //MARK: Animation

    func animationTimer() {

        let center = CGPoint(x: shapeView.frame.width / 2, y: shapeView.frame.height / 2)

        let endAngel = -CGFloat.pi / 2
        let startAngle = 2 * CGFloat.pi + endAngel

        let circularPath = UIBezierPath(arcCenter: center, radius: 128, startAngle: startAngle, endAngle: endAngel, clockwise: false)

        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 25
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeColor =  ViewController.color.cgColor
        shapeView.layer.addSublayer(shapeLayer)
    }

    func basicAnimation() {

        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")

        basicAnimation.toValue = 0
        basicAnimation.duration = CFTimeInterval(minutesDurationTimer * 60 + secondsDurationTimer)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }

    func stopAnimation() {

        if let strokeEnd = shapeLayer.presentation()?.strokeEnd {
            shapeLayer.strokeEnd = strokeEnd
            shapeLayer.removeAllAnimations()
        }
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

        view.addSubview(timerButton)
        NSLayoutConstraint.activate([
            timerButton.bottomAnchor.constraint(equalTo: shapeView.bottomAnchor, constant: -70),
            timerButton.centerXAnchor.constraint(equalTo: shapeView.centerXAnchor),
            timerButton.heightAnchor.constraint(equalToConstant: 50),
            timerButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}

