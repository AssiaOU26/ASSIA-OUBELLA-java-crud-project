package ma.tp.gestionlivres.dao;

public class TestDB {

    public static void main(String[] args) {
        try {
            DBConnection.getConnection();
            System.out.println("DB CONNECTED ✅");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
