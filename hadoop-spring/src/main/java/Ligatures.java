import java.text.Normalizer;

/**
 * Created by ariyabala on 04/04/16.
 */
public class Ligatures {

    private static String test = "ﬁ";
    public static void main(String args[]){
        System.out.println(test.length());
        System.out.println(Normalizer.normalize(test, Normalizer.Form.NFKD).length());
    }
}
