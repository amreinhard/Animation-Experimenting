//
//  ViewController.swift
//  Animation Experimenting
//
//  Created by Amanda Reinhard on 6/13/18.
//  Copyright © 2018 Amanda Reinhard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var animator: UIViewPropertyAnimator!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(slider)
        
        let play = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(playTapped))
        let flip = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(reverseTapped))
        navigationItem.rightBarButtonItems = [play, flip]
        
        slider.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        slider.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        let redBox = UIView(frame: CGRect(x: -64, y: 0, width: 128, height: 128))
        redBox.translatesAutoresizingMaskIntoConstraints = false
        redBox.backgroundColor = UIColor.red
        redBox.center.y = view.center.y
        view.addSubview(redBox)
        
        animator = UIViewPropertyAnimator(duration: 20, dampingRatio: 0.5) { [unowned self, redBox] in
            redBox.center.x = self.view.frame.width
            redBox.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        
//        UIView.animate(withDuration: 20, delay: 0, options: .allowUserInteraction, animations: {
//           redBox.center.x = self.view.frame.width
//        }, completion: nil)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(boxTapped))
        redBox.addGestureRecognizer(recognizer)
        
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        
        animator.addCompletion { [unowned self] position in
            if position == .end {
                self.view.backgroundColor = UIColor.green
            } else {
                self.view.backgroundColor = UIColor.black
            }
        }
    }
    
    @objc func playTapped() {
        if animator.state == .active {
            animator.stopAnimation(false)
            animator.finishAnimation(at: .end)
        } else {
            animator.startAnimation()
        }
    }
    
    @objc func boxTapped() {
        print("Box tapped")
    }
    
    @objc func reverseTapped() {
        animator.isReversed = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func sliderChanged(_ sender: UISlider) {
        animator.fractionComplete = CGFloat(sender.value)
    }

}

