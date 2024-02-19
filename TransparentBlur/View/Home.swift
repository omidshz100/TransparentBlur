//
//  Home.swift
//  TransparentBlur
//
//  Created by Omid Shojaeian Zanjani on 19/02/24.
//// 

import SwiftUI

struct Home: View {
    @State private var imageName:String = "Pic 1"
    @State private var blurtype:BlurType = .clipped
    var body: some View {
        GeometryReader{
            let safeArea = $0.safeAreaInsets
            
            ScrollView(.vertical){
                VStack(spacing: 15){
                    
                    TransparentBlurView(removeAllFilter: true)
                        .blur(radius: 15, opaque: blurtype == .clipped)
                        .padding([.horizontal,.top], -30)
                        .frame(height: 100 + safeArea.top)
                        .visualEffect { content, geometryProxy in
                            content.offset(y: geometryProxy.bounds(of: .scrollView)?.minY ?? 0)
                        }
                    // placing it over other views
                        .zIndex(1000)
                    
                    VStack(alignment: .leading, spacing: 10, content: {
                        GeometryReader{
                            let size = $0.size
                            Image(imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height)
                                .clipShape(.rect(cornerRadius: 25, style: .continuous))
                        }
                        .frame(height: 500)
                        
                        Text("\(blurtype.rawValue)")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.top, 15)
                        
                        Picker("", selection: $blurtype) {
                            ForEach(BlurType.allCases, id:\.self){blurTypeItem in
                                Text(blurTypeItem.rawValue)
                                    .tag(blurTypeItem)
                            }
                        }
                        .pickerStyle(.segmented)
                    })
                    .padding(15)
                    .padding(.bottom, 500)
                }
            }// ScrollView
            .scrollIndicators(.hidden)
            .ignoresSafeArea(.container, edges: .top)
        }
    }
}

#Preview {
    ContentView()
}


enum BlurType:String, CaseIterable {
    case clipped = "Clipped"
    case freeSize = "Free Style"
}
