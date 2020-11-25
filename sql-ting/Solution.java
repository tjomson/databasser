import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

public class Solution{
    public static String makeSql(String column1, String column2, String table){
        return "SELECT '"+table+": (" + "PID" + "," + "HID" + ") --> " + "S" + "' AS FD, CASE WHEN COUNT(*)=0 THEN 'MAY HOLD' ELSE 'does not hold' END AS VALIDITY FROM ( SELECT P."+column1+" FROM "+table+" P GROUP BY P."+column1+" HAVING COUNT(DISTINCT P."+column2+") > 1) X;";
    }

    public static void writeToFile(String column1, String column2, String table, BufferedWriter writer) throws IOException {
        writer.write(makeSql(column1, column2, table));
        writer.newLine();
        writer.newLine();
    }
    public static void main(String[] args) throws IOException {
        String table = "rentals";
        String[] R = new String[]{"PID", "HID", "PN", "S", "HS", "HZ", "HC"};
        BufferedWriter writer = new BufferedWriter(new FileWriter("RScript.txt")); //For outputting a txt file
        for (String column1 : R) {
            for (String column2 : R) {
                if (!column1.equals(column2)) {
                    writeToFile(column1, column2, table, writer);
                }
            }
        }
        writer.close();
    }
}
