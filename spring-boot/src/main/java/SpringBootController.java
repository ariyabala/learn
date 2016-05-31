import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by ariyabala on 20/05/16.
 */
@RestController
public class SpringBootController {

    public @ResponseBody String sayHello(){
        return "Hi Buddy!!! My First Spring Boot";
    }


}
