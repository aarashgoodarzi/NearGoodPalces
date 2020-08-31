# NearGoodPalces

Technical explanations: In NearGoodPalces i used MVVM-C architecture. 
dependencies are: alamofire for networking, kingfisher for downloading images, RxSwift for FRP, and Bagel for network monitoring (that could be removed)
I considered most of swift lint principles, clean code solid principles, dependency inversion priciple, encapsulation and seperation of concerns.
used delegation, dependency injection ,observer pattern and coordinator pattern.
for more information : there's some  wrappers to manage User data, Keychain and etc. a WebService as alamofire wrapper and codable for mapping,
some namespaces for classifying : Global and etc. 

other point that i can mention is that i tried to prevent leaking of bussiness logic to view. view just send reports to viewModel and does not decide anything about bussiness.


