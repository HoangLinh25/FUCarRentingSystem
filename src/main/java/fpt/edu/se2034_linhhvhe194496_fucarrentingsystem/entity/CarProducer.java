package fpt.edu.se2034_linhhvhe194496_fucarrentingsystem.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "car_producers")
public class CarProducer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "producer_id")
    private Long producerID;

    @Column(name = "producer_name", length = 100, nullable = false)
    private String producerName;

    @Column(name = "address", length = 255, nullable = false)
    private String address;

    @Column(name = "country", length = 100, nullable = false)
    private String country;
}
