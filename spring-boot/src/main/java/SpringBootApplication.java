import org.springframework.boot.SpringApplication;

/**
 * Created by ariyabala on 20/05/16.
 */
@org.springframework.boot.autoconfigure.SpringBootApplication(scanBasePackages = "com.ariya.poc.controller")
public class SpringBootApplication {
    public static void main(String args[]){
        SpringApplication.run(SpringBootApplication.class, args);
    }
}
