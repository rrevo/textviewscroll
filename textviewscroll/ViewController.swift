//
//  ViewController.swift
//  textviewscroll
//
//  Created by Rahul Revo on 9/16/20.
//  Copyright © 2020 Rahul Revo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let uiTextView = UITextView()
    var bottomConstraint : NSLayoutConstraint?
    
    // MARK: View setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addNotificationObservers()
    }
    
    deinit {
        removeNotificationObservers()
    }
    
    private func setupView() {
        uiTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(uiTextView)
        
        uiTextView.layer.borderWidth = 1
        uiTextView.text = "Hello World!"
        
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            uiTextView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 8),
            uiTextView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -8),
            uiTextView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 8),
        ])
        setBottomConstraint()
    }
    
    // MARK: Keyboard notifications setup
    
    private func addNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    private func removeNotificationObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    // MARK: Keyboard events handler
    
    @objc func keyboardWillChange(notification: Notification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if notification.name == UIResponder.keyboardWillShowNotification ||
            notification.name == UIResponder.keyboardWillChangeFrameNotification {
            setBottomConstraint(keyboardRect.height)
        } else {
            setBottomConstraint()
        }
    }
    
    private func setBottomConstraint(_ height: CGFloat = 0) {
        let guide = view.safeAreaLayoutGuide
        
        if let bottomConstraint = bottomConstraint {
            NSLayoutConstraint.deactivate([
                bottomConstraint
            ])
        }
        bottomConstraint = guide.bottomAnchor.constraint(equalTo: uiTextView.bottomAnchor, constant: height + 10)
        NSLayoutConstraint.activate([
            bottomConstraint!
        ])
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
}
