### Запуск docker-compose через терминал
1. Запустите контейнер:
```bash
docker-compose up -d
```

2. Проверьте подключение из контейнера:
```bash
docker exec -it pushup-db psql -U pushup_user -d pushup_tracker -c "SELECT 1 AS test"
```
### Запуск docker-compose через  run-docker-compse.sh (скрипты)

Создадим файл `run.sh` для удобного запуска Docker Compose:

#### 1. Создаем файл `run.sh` в корне проекта:

```bash
#!/bin/bash

# Скрипт запуска Docker Compose для PushUp Tracker Bot

# Переходим в директорию с docker-compose.yml
cd /home/slayder/pushup-tracker-db

# Запускаем контейнеры в фоновом режиме
echo "Запуск Docker Compose..."
docker-compose up -d

# Проверяем статус контейнеров
echo "Проверка статуса контейнеров..."
docker-compose ps

# Ждем немного для инициализации БД
echo "Ожидание инициализации базы данных..."
sleep 5

# Проверяем логи для подтверждения успешного запуска
echo "Логи контейнера:"
docker-compose logs --tail=10

echo "✅ База данных запущена и готова к работе!"
```

#### 2. Делаем скрипт исполняемым:

```bash
chmod +x run-docker-compse.sh
```

#### 3. Создаем также скрипт для остановки `stop.sh`:

```bash
#!/bin/bash

# Скрипт остановки Docker Compose для PushUp Tracker Bot

# Переходим в директорию с docker-compose.yml
cd /home/slayder/pushup-tracker-db

# Останавливаем контейнеры
echo "Остановка Docker Compose..."
docker-compose down

echo "✅ Контейнеры остановлены!"
```

#### 4. Делаем скрипт остановки исполняемым:

```bash
chmod +x stop-docker-compse.sh
```

#### 5. Создаем скрипт для перезапуска `restart.sh`:

```bash
#!/bin/bash

# Скрипт перезапуска Docker Compose для PushUp Tracker Bot

# Переходим в директорию с docker-compose.yml
cd /home/slayder/pushup-tracker-db

echo "Перезапуск Docker Compose..."
docker-compose down
docker-compose up -d

echo "✅ Контейнеры перезапущены!"
docker-compose ps
```

#### 6. Делаем скрипт перезапуска исполняемым:

```bash
chmod +x restart-docker-compse.sh
```

#### Использование:

**Запуск:**
```bash
./run.sh
```

**Остановка:**
```bash
./stop.sh
```

**Перезапуск:**
```bash
./restart.sh
```

#### Дополнительные улучшения:

1. **Проверка существования директории:**
```bash
#!/bin/bash

COMPOSE_DIR="/home/slayder/pushup-tracker-db"

if [ ! -d "$COMPOSE_DIR" ]; then
    echo "❌ Директория $COMPOSE_DIR не существует!"
    exit 1
fi

cd "$COMPOSE_DIR"
# остальной код...
```

2. **Проверка установленного Docker:**
```bash
#!/bin/bash

# Проверяем, установлен ли Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker не установлен!"
    exit 1
fi

# Проверяем, установлен ли Docker Compose
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose не установлен!"
    exit 1
fi

# остальной код...
```

3. **Скрипт с параметрами:**
```bash
#!/bin/bash

case "$1" in
    "start")
        cd /home/slayder/pushup-tracker-db
        docker-compose up -d
        echo "✅ Контейнеры запущены в фоновом режиме"
        sleep 2
        docker-compose ps
        ;;
    "stop")
        cd /home/slayder/pushup-tracker-db
        docker-compose down
        echo "✅ Контейнеры остановлены"
        ;;
    "restart")
        cd /home/slayder/pushup-tracker-db
        docker-compose down
        echo "⏳ Перезапуск контейнеров..."
        docker-compose up -d
        sleep 2
        docker-compose ps
        echo "✅ Контейнеры перезапущены"
        ;;
    "logs")
        cd /home/slayder/pushup-tracker-db
        docker-compose logs -f
        # Эта команда будет работать до принудительного завершения (Ctrl+C)
        ;;
    "status")
        cd /home/slayder/pushup-tracker-db
        docker-compose ps
        ;;
    *)
        echo "Использование: $0 {start|stop|restart|logs|status}"
        echo "  start   - запустить контейнеры"
        echo "  stop    - остановить контейнеры"
        echo "  restart - перезапустить контейнеры"
        echo "  logs    - показать логи в реальном времени"
        echo "  status  - показать статус контейнеров"
        exit 1
        ;;
esac

# Добавляем паузу для всех команд кроме logs
if [ "$1" != "logs" ]; then
    echo "Нажмите Enter для продолжения..."
    read -r
fi
```

### Настройка Go-приложения

Используйте строку подключения:
```go
connStr := "host=localhost port=5433 user=pushup_user password=simplepass123 dbname=pushup_tracker sslmode=disable"
```

Или с явным указанием метода:
```go
connStr := "postgresql://pushup_user:simplepass123@localhost:5433/pushup_tracker?sslmode=disable&auth_method=md5"
```

