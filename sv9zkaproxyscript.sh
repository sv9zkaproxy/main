#!/bin/bash

# Обновляем списки пакетов
sudo apt-get update

# Устанавливаем необходимые зависимости
sudo apt-get install -y \
    ca-certificates \
    wget \
    gnupg \
    lsb-release \
    nano

# Создаем директорию для ключей
sudo mkdir -p /etc/apt/keyrings

# Создаем временный файл для ключа
TMP_KEYRING="/tmp/docker.gpg"

# Загружаем и добавляем ключ GPG для Docker
wget -O- https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o "$TMP_KEYRING"

# Перемещаем временный файл в нужное место
sudo mv "$TMP_KEYRING" /etc/apt/keyrings/docker.gpg

# Добавляем репозиторий Docker в источники apt
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Обновляем списки пакетов
sudo apt-get update

# Устанавливаем Docker и связанные с ним пакеты
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Загружаем Docker Compose
sudo wget -O /usr/local/bin/docker-compose "https://github.com/docker/compose/releases/download/v2.17.3/docker-compose-$(uname -s)-$(uname -m)"

# Даем права на выполнение
sudo chmod +x /usr/local/bin/docker-compose

# Проверяем установку Docker
docker --version

# Проверяем установку Docker Compose
docker-compose --version

# Создаем docker-compose.yml файл
sudo tee docker-compose.yml > /dev/null