#!/bin/bash

case "$1" in
    "start")
        cd /home/gsr/pushup-tracker-db
        docker-compose up -d
        echo "✅ Контейнеры запущены в фоновом режиме"
        sleep 2
        docker-compose ps
        ;;
    "stop")
        cd /home/gsr/pushup-tracker-db
        docker-compose down
        echo "✅ Контейнеры остановлены"
        ;;
    "restart")
        cd /home/gsr/pushup-tracker-db
        docker-compose down
        echo "⏳ Перезапуск контейнеров..."
        docker-compose up -d
        sleep 2
        docker-compose ps
        echo "✅ Контейнеры перезапущены"
        ;;
    "logs")
        cd /home/gsr/pushup-tracker-db
        docker-compose logs -f
        # Эта команда будет работать до принудительного завершения (Ctrl+C)
        ;;
    "status")
        cd /home/gsr/pushup-tracker-db
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

