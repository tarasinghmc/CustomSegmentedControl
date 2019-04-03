//
//  CustomSegmentControl.swift
//  CustomSegmentControl
//
//  Created by Tara Singh M C on 02/04/19.
//  Copyright © 2019 Tara Singh. All rights reserved.
//

import UIKit

class CustomSegmentedControl: UIControl {

    var buttons = [UIButton]()
    var selector: UIView!
    var selectedSegmentIndex = 0
    var selectorLeadingConstraint: NSLayoutConstraint!
    
    var borderWidth: CGFloat = 0 {
        
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
   var borderColor: UIColor = .clear {
        
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    var textColor: UIColor = .lightGray {
        didSet {
            configureView()
        }
    }

    var items = [String]() {
        
        didSet {
            configureView()
        }
    }
    
    var selectorColor: UIColor = .darkGray {
        
        didSet {
            configureView()
        }
    }
    
    
    var selectorTextColor: UIColor = .black {
        didSet {
            configureView()
        }
    }
    
    public convenience init(items: [String] ) {
    
        self.init()
        self.items = items
        configureView()

    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        
        buttons.removeAll()
        
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        guard items.count > 0 else {
            return
        }
        
        let buttonTitles = items
        
        for buttonTitle in buttonTitles {
            
            let button = UIButton.init(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
        
        }
        
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        
        
        // Create a StackView
        
        let stackView = UIStackView.init(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0.0
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        
        // Bottom Selector
        selector = UIView.init(frame: .zero)
        selector.backgroundColor = selectorColor
        addSubview(selector)
        
        let multiplier: CGFloat = 1.0/CGFloat(items.count)
    
        selector.translatesAutoresizingMaskIntoConstraints = false
        selector.topAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        selector.heightAnchor.constraint(equalToConstant: 3).isActive = true
        selector.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: multiplier).isActive = true
        selectorLeadingConstraint = selector.leadingAnchor.constraint(equalToSystemSpacingAfter: stackView.leadingAnchor, multiplier: multiplier)
        selectorLeadingConstraint.isActive = true
        
    }
    
    @objc func buttonTapped(button: UIButton) {
        
        
        for (buttonIndex,btn) in buttons.enumerated() {
            
            btn.setTitleColor(textColor, for: .normal)
            
            if btn == button {
                selectedSegmentIndex = buttonIndex
                
                let  selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(buttonIndex)
                
                UIView.animate(withDuration: 0.3, animations: {

                    self.selectorLeadingConstraint.constant = selectorStartPosition
                })

                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
        
        sendActions(for: .valueChanged)

    }
    

}
