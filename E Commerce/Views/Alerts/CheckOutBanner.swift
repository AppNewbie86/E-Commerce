import SwiftUI
import URLImage

struct CheckOutBanner: View {
    
    @State private var showingPaymentViewSheet = false
    @StateObject private var viewModel = ProductViewModel()
    @ObservedObject private var sizeViewModel = SizeViewModel()

    var selectedSize: Size? // Die ausgewählte Größe

    let product: Product
    

    var body: some View {
            NavigationView {
                ZStack {

                VStack {
                    HStack {
                        Image("icon-x")
                            .frame(width: 30, height: 30)
                            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 10)
                        
                        Spacer()
                        
                        // subtitle
                        Text("Checkout")
                            .font(
                                Font.custom("Montserrat", size: 17)
                                    .weight(.medium)
                            )
                            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    HStack {
                        Text("Your Cart is Almost Ready")
                            .font(.headline)
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    Button(action: {
                        showingPaymentViewSheet = true
                    }) {
                        Text("Proceed to Payment")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 0.4, green: 0.03, blue: 0.37))
                            .cornerRadius(25)
                    }
                    .sheet(isPresented: $showingPaymentViewSheet) {
                        PaymentView()
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 10)
                    
                    ProgressView(value: 0.5, total: 1.0)
                        .frame(height: 8)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    HStack {
//                        Spacer()
//                        
//                        Rectangle()
//                            .foregroundColor(.clear)
//                            .frame(width: 146, height: 147)
//                           
                        URLImage(URL(string: product.image)!) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(5)
                                }
                                .frame(width: 100, height: 100) // Adjust the frame size as needed
                                .background(Color.gray.opacity(0.1))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 10)
                                
                            
                        
                        // body
                        VStack(alignment: .leading, spacing: 3) {
                            Text("\(product.title)")
                                .font(Font.custom("Montserrat", size: 12))
                                .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                .frame(width: 127, alignment: .topLeading)
                            
                            Text("\(product.description)")
                                .font(Font.custom("Montserrat", size: 10))
                                .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                .frame(width: 115.02538, alignment: .topLeading)
                            
                          //  Text("Selected Quantity: \(selectedQuantity)")


                            // Caption
                            HStack {
                                Text("\(product.price) $")
                                    .font(Font.custom("Montserrat", size: 9))
                                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                    .frame(width: 18.98477, alignment: .topLeading)
                                
                                Text("QTY: 1")
                                    .font(Font.custom("Montserrat", size: 13))
                                    .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                                    .frame(width: 45.7868, alignment: .topLeading)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 2)
                                            .stroke(Color.black, lineWidth: 1)
                                    )
                            }
                        }
                    }
                    
                    Button(action: {
                        // Aktion, die beim Klicken auf den Button ausgeführt wird
                    }) {
                        HStack(alignment: .center, spacing: 10) {
                            Image(systemName: "trash")
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 4)
                        .padding(.vertical, 0)
                        .frame(width: 69, alignment: .center)
                        .background(Color(red: 0.4, green: 0.03, blue: 0.37))
                        .cornerRadius(34)
                    }

                    
                    
                    CheckOutAddressCard()
                    DiscountBar()
                    HStack(alignment: .center) {
                        // Space Between
                        Spacer()
                        
                        // Alternative Views and Spacers
                        Text("ALTERNATIV PAYMENT METHODS")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 15)
                            .frame(width: 317, alignment: .center)
                            .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                            .cornerRadius(5)
                        
                        Spacer()
                    }
                }
                .frame(width: 360, height: 800)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 10)
                .background(Color.white)
                .cornerRadius(10)
                .onAppear {
                    viewModel.fetchProducts()
                    sizeViewModel.loadSizes() // Lade die Größen
                    
                    if sizeViewModel.selectedSize == nil {
                        sizeViewModel.selectedSize = sizeViewModel.sizes.first // Wähle eine Standardgröße aus, falls keine ausgewählt wurde
                    }
                }


            }
        }
    }
}
