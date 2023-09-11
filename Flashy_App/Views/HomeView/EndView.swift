//
//  EndView.swift
//  Flashy_App
//
//  Created by Artem Snisarenko on 2023-09-09.
//

import SwiftUI

struct EndView: View {
    
    var body: some View {
        VStack {
            
             Text("Set finished👍")
                .bold()
                
            
            Button(action: {
                
            })
            {
                Text("Start again")
            }
        }
    }
}

struct EndView_Previews: PreviewProvider {
    static var previews: some View {
        EndView()
    }
}
