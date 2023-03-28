//
//  LoadingView.swift
//  20230328-RuthwickSRai-NYCSchools
//
//  Created by Ruthwick S Rai on 28/03/23.
//

import Foundation
import UIKit

class LoadingView: NSObject {
    lazy var legacyLoadingView: UIView = {
        let vw = UIView(frame: .zero)
        return vw
    }()

    var activityView: UIActivityIndicatorView?
    var inputLabel: UILabel?
    var spinnerSquare: UIView?
    private var isLoading = false

    @objc func add(withText loadingText: String?, into supperView: UIView?) {
        
        if isLoading {
            return
        }
        
        isLoading = true
        
        DispatchQueue.main.async {
            self.legacyLoadingView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: supperView?.frame.size.width ?? 0.0, height: supperView?.frame.size.height ?? 0.0))
        }
        legacyLoadingView.backgroundColor = UIColor.clear
        legacyLoadingView.alpha = 0.2

        activityView = UIActivityIndicatorView(style: .whiteLarge)

        let supperViewX = ((supperView?.frame.size.width ?? 0.0) - (activityView?.frame.size.width ?? 0.0)) / 2
        let supperViewY = (((supperView?.frame.size.height ?? 0.0) - (activityView?.frame.size.height ?? 0.0)) / 2) - 30

        activityView?.frame = CGRect(x: supperViewX, y: supperViewY, width: activityView?.frame.size.width ?? 0.0, height: activityView?.frame.size.height ?? 0.0)

        var labelFrame = activityView?.frame
        labelFrame?.origin.x -= 20
        labelFrame?.origin.y += (activityView?.frame.size.height ?? 0) + 5
        labelFrame?.size.width += 40
        labelFrame?.size.height = 15

        inputLabel = UILabel(frame: labelFrame ?? .zero)
        inputLabel?.backgroundColor = .clear
        inputLabel?.text = loadingText
        inputLabel?.font = UIFont(name: "Helvetica Neue", size: 13)
        inputLabel?.textAlignment = .center
        inputLabel?.textColor = UIColor.white

        let spinnerSquareX = (activityView?.frame.origin.x ?? 0.0) - 25
        let spinnerSquareY = (activityView?.frame.origin.y ?? 0.0) - 10

        spinnerSquare = UIView(frame: CGRect(x: spinnerSquareX, y: spinnerSquareY, width: (activityView?.frame.size.width ?? 0.0) + 50, height: (activityView?.frame.size.width ?? 0.0) + 45))
        spinnerSquare?.backgroundColor = UIColor.crateTitleColor
        spinnerSquare?.layer.cornerRadius = 5
        spinnerSquare?.layer.masksToBounds = true

        DispatchQueue.main.async {
            self.activityView?.startAnimating()
            supperView?.addSubview(self.legacyLoadingView)
            supperView?.addSubview(self.spinnerSquare ?? UIView())
            supperView?.addSubview(self.activityView ?? UIActivityIndicatorView())
            supperView?.addSubview(self.inputLabel ?? UILabel())
            supperView?.bringSubviewToFront(self.legacyLoadingView)
            supperView?.bringSubviewToFront(self.spinnerSquare ?? UIView())
            supperView?.bringSubviewToFront(self.activityView ?? UIActivityIndicatorView())
            supperView?.bringSubviewToFront(self.inputLabel ?? UILabel())
        }
    }

    @objc func dismissLoadingView() {
        
        isLoading = false
        
        DispatchQueue.main.async {
            self.spinnerSquare?.removeFromSuperview()
            self.inputLabel?.removeFromSuperview()
            self.legacyLoadingView.removeFromSuperview()
            self.activityView?.removeFromSuperview()
        }
    }
}

extension UIColor {
    public class var crateTitleColor: UIColor {
        return UIColor(red: 55 / 255, green: 55 / 255, blue: 55 / 255, alpha: 1.0)
    }
}
