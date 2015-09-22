<p align="center">
    <img src="https://cloud.githubusercontent.com/assets/601431/10017520/6563ec6e-612f-11e5-872f-0d75c3b31fd2.gif">
</p>
<h1 align="center">Page Control</h1>

## Installation
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![GitHub release](https://img.shields.io/github/release/kasper-lahti/PageControl.svg?style=flat)](https://github.com/kasper-lahti/PageControl/releases)

## Usage Example
```swift
import UIKit
import PageControl

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: PageControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        pageControl.numberOfPages = Int(scrollView.contentSize.width / scrollView.bounds.width)
        pageControl.addTarget(self, action: "pageControlDidChangeCurrentPage:", forControlEvents: .ValueChanged)
    }

    func pageControlDidChangeCurrentPage(pageControl: PageControl) {
        scrollView.setContentOffset(CGPoint(x: scrollView.bounds.width * CGFloat(pageControl.currentPage), y: 0), animated: true)
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.dragging || scrollView.decelerating {
            let page = scrollView.contentOffset.x / scrollView.bounds.width
            pageControl.setCurrentPage(page)
        }
    }
}
```

-----------

[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://raw.githubusercontent.com/kasper-lahti/PageControl/master/LICENSE.md) 
