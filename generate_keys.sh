#!/bin/bash

# Запрос пароля
read -s -p "Введите пароль для подключения к Redis: " REDIS_PASSWORD
echo

# Экспорт пароля в переменную окружения
export REDISCLI_AUTH="$REDIS_PASSWORD"

# Параметры подключения к Redis
REDIS_HOST="c-id.rw.mdb.yandexcloud.net"
REDIS_PORT="6380"

# Количество ключей
NUM_KEYS=1000000

# Цикл для создания ключей
for ((i=1; i<=NUM_KEYS; i++))
do
  # Генерация случайного ключа и значения
  KEY="key:$i"
  VALUE=$(openssl rand -hex 10)  # Генерация случайного значения длиной 20 символов

  # Отправка команды SET в Redis
  redis-cli -h "$REDIS_HOST" -p "$REDIS_PORT" --tls SET "$KEY" "$VALUE" > /dev/null

  # Вывод прогресса
  if ((i % 10000 == 0)); then
    echo "Created $i keys..."
  fi
done

echo "All $NUM_KEYS keys created."
