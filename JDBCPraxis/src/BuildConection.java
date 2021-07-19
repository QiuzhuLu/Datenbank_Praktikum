import java.time.LocalDate;
import java.util.Date;

public class BuildConection {
    public static void main(String[] args) {
        Connection con1 = new Connection();
        Ehemalige ehemalige1 = new Ehemalige(1,"Mueller", "Max",
                LocalDate.of(1990, 1, 3), "Maxi", "1234", "maxmueller.gmail.com", "Maennlich");
        try {
            con1.InsertEhemalige(ehemalige1);
            con1.SelectAllFromEhemalige();
        } catch (Throwable throwable) {
            throwable.printStackTrace();
        }
    }
}
