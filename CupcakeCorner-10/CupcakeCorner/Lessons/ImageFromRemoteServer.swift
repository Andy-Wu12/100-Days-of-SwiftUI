//
//  ImageFromRemoteServer.swift
//  CupcakeCorner
//
//  Created by Andy Wu on 1/7/23.
//

import SwiftUI

/* If you want to load a remote image from the internet,
   you need to use AsyncImage instead of Image
*/
struct ImageFromRemoteServer: View {
    var body: some View {
        VStack {
            /*
             Notice how the modifiers for this don't work
             SwiftUI doesn't know the size of our remote images until they are fetched.
             The modifiers here affect the wrapper around the image,
             not the final image itself
             */
//            AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3)
//            // .resizable()
//                .frame(width: 200, height: 200)
            
            /*
             If we want to make the finished image view be both
             resizable and scaled to fit...
             we need to pass the final image view once its ready,
             which we can then customize as needed.
             */
            AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 200, height: 200)
            
            /*
                There is a third way of using AsyncImage that provides complete control over a remote image
                    that always tells us whether the image was loaded,
                    hit an error, or hasn't finished yet.
                This is useful for showing views dedicated to errors
            */
            AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Text("There was an error loading the image.")
                } else {
                    ProgressView()
                }
            }
            .frame(width: 200, height: 200)
        }
    }
}

struct ImageFromRemoteServer_Previews: PreviewProvider {
    static var previews: some View {
        ImageFromRemoteServer()
    }
}
