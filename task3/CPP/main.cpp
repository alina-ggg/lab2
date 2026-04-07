#include <iostream>

using namespace std;

int main() {
    int N;
    cin >> N;
    if (N <= 1) {
        cout << 0 << endl;
        return 0;
    }
 
    int now; // текущее число
    int last; // предыдущее число
    int count = 0; // число совпадений

    cin >> last;

    for (int i = 0; i < N - 1; ++i) {
        cin >> now;

        if (now == last) {
            count++;
        }

        last = now;
    }

    cout << count << endl;
    return 0;

}