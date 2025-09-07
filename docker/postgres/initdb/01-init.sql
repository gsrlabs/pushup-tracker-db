-- Основная таблица пользователей
CREATE TABLE users (
    user_id BIGINT PRIMARY KEY,
    username VARCHAR(100) NOT NULL DEFAULT '',
    max_reps INT NOT NULL DEFAULT 0,
    daily_norm INT NOT NULL DEFAULT 40,
    notifications_enabled BOOLEAN NOT NULL DEFAULT TRUE,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Таблица ежедневной статистики
CREATE TABLE pushups (
    record_id SERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    date DATE NOT NULL,
    count INT NOT NULL DEFAULT 0
);

-- Индексы для ускорения запросов
CREATE INDEX idx_pushups_user_date ON pushups(user_id, date);
CREATE INDEX idx_pushups_date ON pushups(date);

