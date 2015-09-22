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
    
    let pageControl = PageControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = 4
        view.addSubview(pageControl)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var center = view.center
        center.y += view.bounds.height / 2.0 - 50
        pageControl.center = center
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.bounds.width
        pageControl.setCurrentPage(page)
    }
}
```

-----------

[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://raw.githubusercontent.com/kasper-lahti/PageControl/master/LICENSE.md) 
