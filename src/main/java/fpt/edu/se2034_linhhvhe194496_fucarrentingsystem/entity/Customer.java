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
@Table(name = "customers")
public class Customer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "customer_id")
    private Long customerID;

    @Column(name = "customer_name", length = 150, nullable = false)
    private String customerName;

    @Column(name = "mobile", length = 15, nullable = false)
    private String mobile;
    
    @Column(name = "birthday", nullable = false)
    private LocalDate birthday;
    
    @Column(name = "identity_card", length = 20, nullable = false)
    private String identityCard;

    @Column(name = "licence_number", length = 20, nullable = false)
    private String licenceNumber;
    
    @Column(name = "licence_date", nullable = false)
    private LocalDate licenceDate;

    @OneToOne
    @JoinColumn(name = "account_id", nullable = false, unique = true)
    private Account account;
}
