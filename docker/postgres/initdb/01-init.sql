-- Основная таблица пользователей
CREATE TABLE users (
    user_id BIGINT PRIMARY KEY,
    username VARCHAR(100) NOT NULL DEFAULT '',
    max_reps INT NOT NULL DEFAULT 0,
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

-- Тестовые данные (опционально)
INSERT INTO users (user_id, username) VALUES 
(123456, 'test_user1'),
(654321, 'test_user2');

INSERT INTO pushups (user_id, date, count) VALUES
(123456, CURRENT_DATE, 30),
(654321, CURRENT_DATE, 45);
