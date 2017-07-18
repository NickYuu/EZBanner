//
//  EZBanner.swift
//  EZBanner
//
//  Created by TsungHan on 2017/7/17.
//  Copyright © 2017年 TsungHan. All rights reserved.
//

import UIKit

open class EZBanner: UIView {
    
    @IBOutlet weak fileprivate var scrollView: UIScrollView!
    @IBOutlet weak fileprivate var pageControl: UIPageControl!
    fileprivate var timer: Timer!
    fileprivate var timeInterval = 1.5
    fileprivate var images: [UIImage] = [] {
        didSet {
            let count = images.count
            
            for image in images {
                let imageView = UIImageView(image: image)
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                scrollView.addSubview(imageView)
            }
            pageControl.numberOfPages = count
        }
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.scrollView.delegate = self
        self.pageControl.hidesForSinglePage = true
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        let scrollViewWidth = scrollView.frame.size.width
        let scrollViewHeight = scrollView.frame.size.height
        
        
        for i in 0..<images.count {
            self.scrollView.subviews[i].frame = CGRect(x: CGFloat(i) * scrollViewWidth, y: 0, width: scrollViewWidth, height: scrollViewHeight)
        }
        
        self.scrollView.contentSize = CGSize(width: CGFloat(images.count) * scrollViewWidth, height: scrollViewHeight)
    }
    
    
    

}

extension EZBanner {
    
    open func start() {
        startTimer()
    }
    
    fileprivate func startTimer() {
        timer = Timer(timeInterval: timeInterval, target: self, selector: #selector(nextPage), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .commonModes)
    }
    
    fileprivate func stopTimer() {
        timer.invalidate()
    }
    
    
    @objc fileprivate func nextPage() {
        var page = self.pageControl.currentPage + 1
        if page == self.images.count {
            page = 0
        }
        let point = CGPoint(x: scrollView.frame.size.width * CGFloat(page), y: 0)
        scrollView.setContentOffset(point, animated: true)
    }
    
}

extension EZBanner: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width + 0.5
        pageControl.currentPage = Int(page)
    }
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        startTimer()
    }
}


extension EZBanner {
    
    public class func create(_ images: [UIImage], interval:TimeInterval = 1.5) -> EZBanner {
        let bundle = Bundle(for: self)
        let name = String(describing: self)
        let view = bundle.loadNibNamed(name, owner: nil, options: nil)?.first as! EZBanner
        view.images = images
        view.timeInterval = interval
        return view
    }
}
