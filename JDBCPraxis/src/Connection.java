import java.sql.*;
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;

public class Connection {
    java.sql.Connection con;
    public Connection() {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection("url", "username", "password");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }


    public List<Ehemalige> SelectAllFromEhemalige() throws SQLException {
        Statement Ehemalige = con.createStatement();
        String anfrage = "SELECT * FROM EHEMALIGE";
        ResultSet results = Ehemalige.executeQuery(anfrage);
        List<Ehemalige> ehemaligeList = new LinkedList<>();
        while (results.next()) {
            ehemaligeList.add(new Ehemalige(
                    results.getInt("ID"),
                    results.getString("Name"),
                    results.getString("Vorname"),
                    results.getDate("Geburtsdatum").toLocalDate(),
                    results.getString("Geburtsname"),
                    results.getString("Telefonnummer"),
                    results.getString("Email"),
                    results.getString("Geschlecht")
            ));
        }
        results.close();
        Ehemalige.close();
        p(ehemaligeList);
        return ehemaligeList;
    }

    // date'1723-01-02'
    public void InsertEhemalige(Ehemalige ehemalige) throws Throwable {
        Statement stm = con.createStatement();
        String befehl = String.format("INSERT INTO Ehemalige(Name, Vorname, Geburtsdatum, Geburtsname, Telefonnummer, Email, Geschlecht) VALUES ('%s', '%s', date'%s', '%s', '%s', '%s', '%s')",
                ehemalige.Name, ehemalige.Vorname, ehemalige.Geburtsdatum, ehemalige.Geburtsname, ehemalige.Telefonnummer, ehemalige.Email, ehemalige.Geschlecht);
        stm.executeUpdate(befehl);
        stm.close();
    }

    public void InsertEhemalige(Ehemalige person, String bildungseinrichtung, String ort, String von, String bis, String gruppe) throws Throwable {
        con.beginRequest();
        con.setAutoCommit(false);
        Statement stm = con.createStatement();
        try {
            String insEhemCmd = String.format("INSERT INTO Ehemalige(Name, Vorname, Geburtsdatum, Geburtsname, Telefonnummer, Email, Geschlecht) " +
                            "VALUES ('%s', '%s', date'%s', '%s', '%s', '%s', '%s')",
                    person.Name, person.Vorname, person.Geburtsdatum, person.Geburtsname, person.Telefonnummer, person.Email, person.Geschlecht);
            stm.executeUpdate(insEhemCmd, new String[]{"ID"});
            ResultSet keys = stm.getGeneratedKeys();
            long ehemId;
            if (keys.next()) {
                ehemId = keys.getLong(1);
            } else throw new SQLException("Einfügen hat keinen Key geliefert.");

            String bildungseinrichtung_ID = "Select ID from Bildungseinrichtung WHERE Bezeichnung = '%s'".formatted(bildungseinrichtung);
            ResultSet Bildung_IDSet = stm.executeQuery(bildungseinrichtung_ID);
            int Bildung_ID;
            if (Bildung_IDSet.next()) {
                Bildung_ID = Bildung_IDSet.getInt(1);
            } else {
                throw new SQLException("Bildungseinrichtung nicht vorhanden");
            }

            if (!stm.executeQuery(String.format("SELECT Bezeichnung FROM GRUPPE WHERE Bezeichnung = '%s'", gruppe)).next()) {
                stm.executeUpdate(String.format("INSERT INTO GRUPPE(Bezeichnung) VALUES('%s')", gruppe));
            }

            String insHatBesuchtCmd = String.format("INSERT INTO Hat_besucht(Von, Bis, ID_Bildungseinrichtung, ID_Ehemaliger, Gruppe_Bez)" +
                            " VALUES (date'%s', date'%s', %d, %d,'%s')",
                    von, bis, Bildung_ID, ehemId, gruppe);
            stm.executeUpdate(insHatBesuchtCmd);

            con.commit();
        } catch (SQLException throwables) {
            con.rollback();
            throw throwables;
        } finally {
            if (stm != null)
                stm.close();
            con.setAutoCommit(true);
            con.endRequest();
        }
    }

    public List<Ehemalige> SelectAllEhemaligeHawInformatik() throws SQLException {
        Statement Ehemalige = con.createStatement();
        String anfrage = "SELECT * FROM EHEMALIGE E, BILDUNGSEINRICHTUNG B, HAT_BESUCHT HB " +
                "WHERE B.Bezeichnung = 'HAW' AND B.BEZEICHNUNG_Ort = 'Hamburg' AND HB.ID_Bildungseinrichtung = B.ID AND  E.ID = HB.ID_Ehemaliger AND HB.Gruppe_Bez = 'Informatik'";
        ResultSet results = Ehemalige.executeQuery(anfrage);
        List<Ehemalige> ehemaligeInformatikList = new LinkedList<>();
        while (results.next()) {
            ehemaligeInformatikList.add(new Ehemalige(
                    results.getInt("ID"),
                    results.getString("Name"),
                    results.getString("Vorname"),
                    results.getDate("Geburtsdatum").toLocalDate(),
                    results.getString("Geburtsname"),
                    results.getString("Telefonnummer"),
                    results.getString("Email"),
                    results.getString("Geschlecht")
            ));
        }
        results.close();
        Ehemalige.close();
        p(ehemaligeInformatikList);
        return ehemaligeInformatikList;
    }

    public void InsertBildungseinrichtung(String Typ, String bezeichnung, String bezeichnungOrt, String str, String hausnummer, String plz) throws SQLException {
        Statement stm = con.createStatement();
        String insert = String.format("INSERT INTO Bildungseinrichtung(Typ, Bezeichnung, Bezeichnung_Ort, Str, Hausnummer, PLZ) VALUES ('%s','%s', '%s', '%s', '%s', '%s')",
                Typ, bezeichnung, bezeichnungOrt, str, hausnummer, plz);
        stm.executeUpdate(insert);
        stm.close();
    }

    public void InsertOrt(String Ort, String PLZ) throws SQLException {
        Statement stm = con.createStatement();
        String insert = String.format("INSERT INTO Ort(PLZ, Ort) VALUES('%s', '%s')", PLZ, Ort);
        stm.executeUpdate(insert);
        stm.close();
    }

    public void insertHatBesucht(String von, String bis, String idBildungseinrichtung, String idEhemaliger, String gruppeBez) throws SQLException {
        Statement stm = con.createStatement();
        String befehl = String.format("INSERT INTO HAT_BESUCHT(Von, Bis, ID_Bildungseinrichtung, ID_Ehemaliger, Gruppe_Bez) VALUES (date'%s', date'%s', %s, %s,'%s')",
                von, bis, idBildungseinrichtung, idEhemaliger, gruppeBez);
        stm.executeUpdate(befehl);
        stm.close();
    }

    public void logout() {
        try {
            con.close();
            con = null;
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

    private void p(List<Ehemalige> ehem) {
        System.out.println(ehem.stream().map(e -> String.format("%d\t %s, %s, %s, %s", e.Id, e.Name, e.Vorname, e.Email, e.Telefonnummer)).collect(Collectors.joining("\n")));
    }
}
