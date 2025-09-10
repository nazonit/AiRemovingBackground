# 🧼 Приложение для удаления фона (Локальный GUI с rembg)

🎯 Легкое настольное приложение для удаления фона изображений с использованием ИИ (U-2-Net).  
Создано с использованием Python, Tkinter и библиотеки `rembg`. Работает офлайн на процессоре - графический процессор не требуется.

Этот README включает **все шаги**, **структуру папок**, **инструменты** и **ошибки**, с которыми я столкнулся, задокументированные для моей будущей справки.

---

## 📁 Структура папок

Background Extractor/
│
├── assets/ # Необязательно: файлы изображений для тестирования
├── docs/ # Техническая документация
│ ├── technical_specification_ru.md # Техническая спецификация
│ ├── user_guide_ru.md # Руководство пользователя
│ ├── developer_guide_ru.md # Руководство разработчика
│ ├── changelog_ru.md # Журнал изменений
│ └── README.md # README документации
├── utils/
│ └── processor.py # Использует rembg для удаления фона
├── cli_remover.py # Командная строка версия инструмента
├── CLI_README.md # Документация для CLI версии
├── gui.py # Логика графического интерфейса Tkinter
├── main.py # Точка входа для запуска приложения
├── setup_and_run.bat # Полный скрипт установки и запуска
├── install.bat # Скрипт установки для Windows
├── run.bat # Скрипт запуска для Windows
├── requirements.txt # Зависимости Python
├── requirements_RU.txt # Зависимости Python (русская версия)
├── bgremover_env/ # Виртуальная среда (исключена из Git)
├── .gitignore # Игнорировать виртуальную среду, pycache и т.д.
├── README.md # Документация на английском языке
├── README_RU.md # Документация на русском языке (этот файл)
└── TROUBLESHOOTING_RU.md # Руководство по устранению неполадок

---

## 📚 Техническая документация

Подробная техническая документация доступна в директории [docs](docs):
- [Техническая спецификация](docs/technical_specification_ru.md)
- [Руководство пользователя](docs/user_guide_ru.md)
- [Руководство разработчика](docs/developer_guide_ru.md)
- [Журнал изменений](docs/changelog_ru.md)
- [Руководство по устранению неполадок](TROUBLESHOOTING_RU.md)

---

## 🚀 Быстрый старт (Windows)

### Полная установка и запуск (Рекомендуется)
Дважды щелкните `setup_and_run.bat` для:
1. Проверки установки Python
2. Создания виртуальной среды
3. Установки всех зависимостей
4. Проверки установки
5. Возможного запуска приложения

### Графическая версия
1. **Установите приложение:**
   Дважды щелкните `install.bat` или запустите его из командной строки:
   ```bash
   install.bat
   ```

2. **Запустите приложение:**
   Дважды щелкните `run.bat` или запустите его из командной строки:
   ```bash
   run.bat
   ```

### Командная строка версия
Для использования через командную строку:
```bash
python cli_remover.py input.jpg output.png
```

Смотрите [CLI_README.md](CLI_README.md) для подробных инструкций по использованию CLI.

---

## ⚙️ Ручная установка

### 1. Создайте папку проекта

```bash
cd "D:\Models"
mkdir "Background Extractor"
cd "Background Extractor"
```

Или клонируйте этот репозиторий, если он есть на GitHub:

```bash
git clone https://github.com/nazonit/AiRemovingBackground.git
cd AiRemovingBackground
```

### 2. Создайте и активируйте виртуальную среду

```bash
python -m venv bgremover_env
bgremover_env\Scripts\activate
```

### 3. Установите зависимости

```bash
pip install rembg onnxruntime pillow
```

Или используя файл requirements.txt:

```bash
pip install -r requirements.txt
```

Для русской версии:
```bash
pip install -r requirements_RU.txt
```

---

## 🧠 Модель U-2-Net: u2net.onnx

Библиотеке rembg необходимо загрузить модель U-2-Net (u2net.onnx) при первом запуске.

Однако я постоянно сталкивался с сетевыми ошибками:

```
IncompleteRead(X bytes read, Y more expected)
ChunkedEncodingError
WinTLS: Failed to encrypt a message! Error: The context has expired
```

✅ ИСПРАВЛЕНИЕ: Ручная загрузка через aria2

🔧 Шаг 1: Скачайте Aria2 (Портативная версия)
Я скачал:
aria2-1.19.0-win-32bit-build1.zip
→ Распаковал в:
C:\Users\HP\Downloads\aria2-1.19.0-win-32bit-build1\aria2-1.19.0-win-32bit-build1\aria2c.exe

🔧 Шаг 2: Запустите Aria2 для загрузки модели

```bash
"C:\Users\HP\Downloads\aria2-1.19.0-win-32bit-build1\aria2-1.19.0-win-32bit-build1\aria2c.exe" -x 16 -s 16 https://github.com/danielgatis/rembg/releases/download/v0.0.0/u2net.onnx
```

Это загрузит:

```
C:\Users\HP\u2net.onnx
```

⚠️ Модель должна быть размещена в:

```
C:\Users\HP\.u2net\u2net.onnx
```

Если папки .u2net не существует, создайте её вручную.

---

## ▶️ Запуск приложения

### Графическая версия
Используя скрипт запуска:
```bash
run.bat
```

Или вручную:
```bash
python main.py
```

Откроется окно Tkinter. Вы можете:

- Загрузить изображение .png или .jpg
- Нажать кнопку для удаления фона
- Просмотреть и сохранить результат

### Командная строка версия
```bash
python cli_remover.py input.jpg output.png
```

---

## ⚠️ Личные заметки – Ошибки, с которыми я столкнулся

❌ IncompleteRead / ChunkedEncodingError — Происходит во время загрузки модели. Решено с помощью aria2.

❌ WinTLS: Failed to encrypt a message! — Тайм-аут сети или ошибки TLS при загрузке больших файлов. aria2 справляется с этим лучше.

⚠️ onnxruntime_providers_cuda.dll отсутствует —

```
Error loading onnxruntime_providers_cuda.dll: cublasLt64_12.dll is missing
```

Это связано с ускорением GPU (CUDA). Можно безопасно игнорировать. Работает отлично на процессоре.

---

## 💡 Планы на будущее

- Добавить потоки в графический интерфейс, чтобы предотвратить зависание во время обработки
- Преобразовать приложение в автономный .exe с помощью pyinstaller
- Добавить предварительный просмотр изображений для загруженного и обработанного изображения
- Поддержка перетаскивания

---

## 📦 Используемые библиотеки

- rembg – Удаление фона с помощью ИИ
- onnxruntime – Для запуска U-2-Net
- pillow – Загрузка и сохранение изображений
- tkinter – Фреймворк графического интерфейса
- aria2 – Быстрый загрузчик модели с множественными соединениями (ручное исправление)

---

## 🧠 Ссылка (для модели)

Официальная модель U-2-Net, используемая rembg:
📦 https://github.com/danielgatis/rembg
📄 URL модели:
https://github.com/danielgatis/rembg/releases/download/v0.0.0/u2net.onnx

---

## 🛠️ Создано только для локального использования

Нет облачной обработки, нет отслеживания пользователей — просто быстрый и локальный ИИ-инструмент для удаления фона.