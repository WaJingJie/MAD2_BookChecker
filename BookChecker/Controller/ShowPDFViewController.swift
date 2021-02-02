//
//  ShowPDFViewController.swift
//  BookChecker
//
//  Created by MAD2 on 28/1/21.
//

import UIKit
import PDFKit

class ShowPDFViewController: UIViewController{
    
    var contentView:BookList?
    var content:BookList?
    var itemPath:Int!
    var pdf:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //stores the pdf file name as a string
        pdf = contentView?.bookTitle
        
        let pdfView = PDFView()
        
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)
        
        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        pdfView.autoScales = true
        
        pdfView.displayMode = .singlePageContinuous
        
        pdfView.displayDirection = .vertical
        
        //thumbnails for the pages of the pdf viewr
        let thumbnailVIew = PDFThumbnailView()
        thumbnailVIew.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(thumbnailVIew)
        
        thumbnailVIew.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        thumbnailVIew.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        thumbnailVIew.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
        thumbnailVIew.heightAnchor.constraint(equalToConstant: 120).isActive = true
        thumbnailVIew.thumbnailSize = CGSize(width: 100, height: 60)
        thumbnailVIew.layoutMode = .horizontal
        thumbnailVIew.pdfView = pdfView
        
        //code to get the pdf file from the project's local storage directory
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let pdfPath = path.appendingPathComponent(pdf)
        
        let document = PDFDocument(url: pdfPath)
        
        pdfView.document = document
    }
    
    func endSession() {
        self.dismiss(animated: true) {
            print("Back to main controller")
        }
    }

}
extension URL{
    static var documents: URL{
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    }
}
