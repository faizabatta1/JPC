int calculatePurchasePoints(double totalPrice){
  return (totalPrice / 100).ceil() * 1;
}