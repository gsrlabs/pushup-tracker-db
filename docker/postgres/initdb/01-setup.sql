-- Убедимся, что пользователь создан с правильным паролем
ALTER USER pushup_user WITH PASSWORD 'isXzryYpeg9aK7bfDJNu';

-- Проверка (опционально)
SELECT 'Database and user ready' AS status;
