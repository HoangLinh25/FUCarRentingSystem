package fpt.edu.se2034_linhhvhe194496_fucarrentingsystem.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "rent_order_details")
public class RentOrderDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_detail_id")
    private Long orderDetailID;

    @Column(name = "pickup_date", nullable = false)
    private LocalDate pickupDate;
    
    @Column(name = "return_date", nullable = false)
    private LocalDate returnDate;
    
    @Column(name = "rent_price", nullable = false)
    private Double rentPrice;

    @Column(name = "status", nullable = false)
    private Integer status;

    @ManyToOne
    @JoinColumn(name = "order_id", nullable = false)
    private RentOrder rentOrder;

    @ManyToOne
    @JoinColumn(name = "car_id", nullable = false)
    private Car car;
}
