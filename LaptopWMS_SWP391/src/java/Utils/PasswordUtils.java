/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import org.mindrot.jbcrypt.BCrypt;
/**
 *
 * @author PC
 */
public class PasswordUtils {

    public static String hashPassword(String plainTextPassword) {
        return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt(11));
    }

    public static boolean checkPassword(String plainTextPassword, String hashedPassword) {
        if (hashedPassword == null || !hashedPassword.startsWith("$2a$")) {
            return false;
        }
        return BCrypt.checkpw(plainTextPassword, hashedPassword);
    }

    public static void main(String[] args) {
        String testPassword = "123456";
        String hash = hashPassword(testPassword);
        
        System.out.println("--- GENERATING HASH ---");
        System.out.println("Password: " + testPassword);
        System.out.println("Hash:     " + hash);
        System.out.println("-----------------------");
        
        boolean match = checkPassword("123456", hash);
        System.out.println("Does '123456' match the hash? " + match);
    }
}
