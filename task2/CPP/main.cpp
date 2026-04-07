#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

struct Meeting {
    int start; // Время начала встречи
    int end; // Время окончания встречи
    int id; // Исходный порядковый номер
};

// Функция для сравнения времени окончания и начала для выстраивания очереди из заявок
bool srvnMeeting(const Meeting& a, const Meeting& b) {
    if (a.end != b.end) {
        return a.end < b.end;
    }
    return a.start < b.start;
}

int main() {
    int N;
    cin >> N; // Считывание количества заявок

    // Контейнер размером N из структуры
    vector<Meeting> meetings(N);
    for (int i = 0; i < N; ++i) {
        cin >> meetings[i].start >> meetings[i].end;
        meetings[i].id = i + 1;
    }

    // Перемешиваем заявки, чтобы в начале были те, которые заканчиваются раньше всех
    sort(meetings.begin(), meetings.end(), srvnMeeting);

    vector<int> selectId; // Контейнер для записи номеров встреч
    int freeTime = -1; // Время, когда освободиться комната

    for (int i = 0; i < N; ++i) {
        if (meetings[i].start >= freeTime) {
            selectId.push_back(meetings[i].id); // Добавление номера встречи в результат
            freeTime = meetings[i].end;
        }
    }

    cout << selectId.size() << ","; // Общее количество выбранных встреч

    sort(selectId.begin(), selectId.end()); // Сортировка по возрастанию

    for (int id : selectId) {
        cout << " " << id;
    }
    cout << endl;

    return 0;
}