-- Убедимся, что пользователь создан с правильным паролем
ALTER USER pushup_user WITH PASSWORD 'simplepass123';

-- Проверка (опционально)
SELECT 'Database and user ready' AS status;
