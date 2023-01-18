//
//  OnboardingViewController.swift
//  schedule_app
//
//  Created by Акжан Калиматов on 19.01.2023.
//

import UIKit



class OnboardingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    // Array of slides
    var slides: [OnboardingSlide] = []
    var window: UIWindow?
    var vc: UIViewController?
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Get Started", for: .normal)
            } else {
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        nextBtn.layer.cornerRadius = 10
        
        
        // Presentation Slider information
        
        slides = [
            OnboardingSlide(title: "Convenient schedule", description: "A schedule for each student for three whole days", image: #imageLiteral(resourceName: "1")),
            OnboardingSlide(title: "List of Teachers ", description: "You can get information about any professor at the university", image: #imageLiteral(resourceName: "2")),
            OnboardingSlide(title: "It's all on the phone!", description: "All the convenience and usefulness in one mobile app, enjoy!", image: #imageLiteral(resourceName: "3"))
        ]
        
        pageControl.numberOfPages = slides.count
    }
    
    // To change slide
    
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            let controller = storyboard?.instantiateViewController(identifier: "mainVC") as! MainViewController
            controller.modalPresentationStyle = .fullScreen
            UserDefaults.standard.hasOnboarded = true
            present(controller, animated: true, completion: nil)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}



// Using collection view to add and change slides

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}

