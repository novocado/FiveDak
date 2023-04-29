package semiproject.dak.product.model;

import java.util.List;

public class CheckoutDTO {
    private List<CartDTO> cartDtoList;
    private int totalPrice;
    private int totalDiscount;
    private int shippingCost;
    private int pointsEarned;
    private int totalAmount;

    public CheckoutDTO(List<CartDTO> cartDtoList, int totalPrice, int totalDiscount, int shippingCost, int pointsEarned, int totalAmount) {
        this.cartDtoList = cartDtoList;
        this.totalPrice = totalPrice;
        this.totalDiscount = totalDiscount;
        this.shippingCost = shippingCost;
        this.pointsEarned = pointsEarned;
        this.totalAmount = totalAmount;
    }

    public List<CartDTO> getCartDTOList() {
        return cartDtoList;
    }

    public void setCartDtoList(List<CartDTO> CartDTOList) {
        this.cartDtoList = CartDTOList;
    }

    public int getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getTotalDiscount() {
        return totalDiscount;
    }

    public void setTotalDiscount(int totalDiscount) {
        this.totalDiscount = totalDiscount;
    }

    public int getShippingCost() {
        return shippingCost;
    }

    public void setShippingCost(int shippingCost) {
        this.shippingCost = shippingCost;
    }

    public int getPointsEarned() {
        return pointsEarned;
    }

    public void setPointsEarned(int pointsEarned) {
        this.pointsEarned = pointsEarned;
    }

    public int getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(int totalAmount) {
        this.totalAmount = totalAmount;
    }
}