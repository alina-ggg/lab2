const fs = require('fs'); // Встроенный модуль для работы с файлами и вводом

const input = fs.readFileSync(0, 'utf8').split(/\s+/); // Чтение ввода, разделение по пробелам
let idx = 0; // Указатель на слово, которое читаем

const N = parseInt(input[idx++]); // Чтение числа и сдвигание указателя
if (isNaN(N)) process.exit(); // Если нет данных - выход

const meetings = [];

for (let i = 1; i <= N; i++) {
    const start = parseInt(input[idx++])
    const end = parseInt(input[idx++])

    meetings.push({
        start: start,
        end: end,
        id: i
    });
}

meetings.sort((a,b) => {
    if (a.end !== b.end) {
        return a.end - b.end;
    }
    return a.start - b.start
});

const selectId = [];
let freeTime = -1;

for (const m of meetings) {
    if (m.start >= freeTime) {
        selectId.push(m.id);
        freeTime = m.end;
    }
}

process.stdout.write(selectId.length + ",");

selectId.sort((a, b) => a - b);

console.log(" " + selectId.join(" "));