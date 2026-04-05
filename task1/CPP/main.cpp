#include <iostream>
#include <string>
#include <vector>

using namespace std;

// Функция проверяет, содержит ли подстрока все символы из T
bool allSymvl(string str, string t) {
    vector<int> count(128, 0);
    
    // Считаем символы в подстроке
    for (char c : str) {
        count[c]++;
    }
    
    // Проверяем, хватает ли каждого символа из T
    for (char c : t) {
        count[c]--;
        if (count[c] < 0) return false;
    }
    return true;
}

string minStr(string s, string t) {
    if (t.length() > s.length()) return "Не найдено";
    
    string result = "";
    int minLen = s.length() + 1;
    
    // Перебираем все возможные подстроки
    for (int i = 0; i < s.length(); ++i) {
        for (int j = i; j < s.length(); ++j) {
            string str = s.substr(i, j - i + 1); // Вырезаем подстроку
            
            if (allSymvl(str, t)) {
                if (str.length() < minLen) {
                    minLen = str.length();
                    result = str;
                }
                break; // для этого i дальше смысла нет
            }
        }
    }
    
    return result.empty() ? "Не найдено" : result;
}

int main() {
    string s, t;
    cin >> s;
    cin >> t;
    cout << minStr(s,t) << endl;
    return 0;
}