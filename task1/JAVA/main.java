import java.util.Scanner;

public class main {

    // Функция проверяет, содержит ли подстрока все символы из T
    public static boolean allSymvl(String str, String t) {
        int[] count = new int[128];

        // Считаем символы в подстроке
        for (char c : str.toCharArray()) {
            count[c]++;
        }

        // Проверяем, хватает ли каждого символа из T
        for (char c : t.toCharArray()) {
            count[c]--;
            if (count[c] < 0) return false;
        }
        return true;
    }

    public static String minStr(String s, String t) {
        if (t.length() > s.length()) return "Не найдено";

        String result = "";
        int minLen = s.length() + 1;

        // Перебираем все возможные подстроки
        for (int i = 0; i < s.length(); i++) {
            for (int j = i; j < s.length(); j++) {
                String sub = s.substring(i, j + 1);

                if (allSymvl(sub, t)) {
                    if (sub.length() < minLen) {
                        minLen = sub.length();
                        result = sub;
                    }
                    break; // Для этого i нашли минимальную подстроку
                }
            }
        }

        return result.isEmpty() ? "Не найдено" : result;
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        if (sc.hasNextLine()) {
            String s = sc.nextLine();
            if (sc.hasNextLine()) {
                String t = sc.nextLine();
                System.out.println(minStr(s, t));
            }
        }
        sc.close();
    }
}