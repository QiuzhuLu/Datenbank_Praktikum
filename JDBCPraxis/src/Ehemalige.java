

import java.time.LocalDate;

public class Ehemalige {
    public int Id ;
    public String Name ;
    public String Vorname ;
    public LocalDate Geburtsdatum ;
    public String Geburtsname ;
    public String Telefonnummer ;
    public String Email ;
    public String Geschlecht ;

    public Ehemalige(int id, String name, String vorname, LocalDate geburtsdatum, String geburtsname, String telefonnummer, String email, String geschlecht) {
        Id = id;
        Name = name;
        Vorname = vorname;
        Geburtsdatum = geburtsdatum;
        Geburtsname = geburtsname;
        Telefonnummer = telefonnummer;
        Email = email;
        Geschlecht = geschlecht;
    }
}
