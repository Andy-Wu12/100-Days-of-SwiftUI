//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Andy Wu on 1/8/23.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    @State private var orderErrorMessage = ""
    @State private var showOrderError = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                .accessibilityElement()
                
                Text("Your total is \(order.details.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    /*
                     Just place this here doesn't work since buttons expect their actions to happen immediately.
                     task() won't work either since we are executing an action rather than attaching modifiers.
                    */
                    // placeOrder()
                    
                    // The solution is to create a Task
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
                .alert("Order Error", isPresented: $showOrderError) {
                    Button("OK") { showOrderError = false }
                } message: {
                    Text(orderErrorMessage)
                }
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order.details) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(OrderDetails.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(OrderDetails.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            orderErrorMessage = "Error occurred! Please try again."
            showOrderError = true
        }
        
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
