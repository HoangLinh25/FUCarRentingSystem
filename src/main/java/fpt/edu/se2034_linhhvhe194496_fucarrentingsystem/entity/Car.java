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
@Table(name = "cars")
public class Car {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "car_id")
    private Long carID;

    @Column(name = "car_name", length = 100, nullable = false)
    private String carName;

    @Column(name = "car_model_year", nullable = false)
    private Integer carModelYear;

    @Column(name = "color", length = 50, nullable = false)
    private String color;

    @Column(name = "capacity", nullable = false)
    private Integer capacity;

    @Column(name = "description", columnDefinition = "NVARCHAR(MAX)", nullable = false)
    private String description;
    
    @Column(name = "import_date", nullable = false)
    private LocalDate importDate; 
    
    @Column(name = "rent_price", nullable = false)
    private Double rentPrice;

    @Column(name = "status", nullable = false)
    private Integer status;

    @ManyToOne
    @JoinColumn(name = "producer_id", nullable = false)
    private CarProducer carProducer;
}
