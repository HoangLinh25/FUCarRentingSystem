package fpt.edu.se2034_linhhvhe194496_fucarrentingsystem;

import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

public class ServletInitializer extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(Se2034LinhHvhe194496FuCarRentingSystemApplication.class);
    }

}
