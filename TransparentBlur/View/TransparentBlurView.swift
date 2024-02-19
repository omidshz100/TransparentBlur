//
//  TransparentBlurView.swift
//  TransparentBlur
//
//  Created by Omid Shojaeian Zanjani on 19/02/24.
//

import SwiftUI

struct TransparentBlurView: UIViewRepresentable {
    var removeAllFilter: Bool = false
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        
        return view
    }
  
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        DispatchQueue.main.async {
            if let backDropLayer = uiView.layer.sublayers?.first {
                if removeAllFilter {
                    backDropLayer.filters = []
                }else {
                    backDropLayer.filters?.removeAll(where: { filter in
                        String(describing: filter) != "gaussianBlur"
                    })
                }
            }
        }
    }
}

#Preview {
    TransparentBlurView()
        .padding(15)
}
