package semiproject.dak.product.model;

public class OrderDetailDTO {
    
     private int order_detail_id;
     private int order_id; 
     private int  order_detail_product_id;     //주문상세내역의 제품번호
     private int order_quantity;           // 제품에 대한 주문수량
     private int price_per_unit;         //  개당가격
   
     public OrderDetailDTO() {} // 기본생성자 
     
     public OrderDetailDTO(int order_detail_id, int order_id, int order_detail_product_id, int order_quantity,
         int price_per_unit) {
      super();
      this.order_detail_id = order_detail_id;
      this.order_id = order_id;
      this.order_detail_product_id = order_detail_product_id;
      this.order_quantity = order_quantity;
      this.price_per_unit = price_per_unit;
   }

   public int getOrder_detail_id() {
      return order_detail_id;
   }

   public void setOrder_detail_id(int order_detail_id) {
      this.order_detail_id = order_detail_id;
   }

   public int getOrder_id() {
      return order_id;
   }

   public void setOrder_id(int order_id) {
      this.order_id = order_id;
   }

   public int getOrder_detail_product_id() {
      return order_detail_product_id;
   }

   public void setOrder_detail_product_id(int order_detail_product_id) {
      this.order_detail_product_id = order_detail_product_id;
   }

   public int getOrder_quantity() {
      return order_quantity;
   }

   public void setOrder_quantity(int order_quantity) {
      this.order_quantity = order_quantity;
   }

   public int getPrice_per_unit() {
      return price_per_unit;
   }

   public void setPrice_per_unit(int price_per_unit) {
      this.price_per_unit = price_per_unit;
   };            
   
   
}