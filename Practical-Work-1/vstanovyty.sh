#!/usr/bin/env bash

set -u

read -r -p "Введіть назву об'єкта, який потрібно встановити: " object_name

if [[ -z "$object_name" ]]; then
    echo "Помилка: назву об'єкта не вказано."
    exit 1
fi

if [[ -e "$object_name" ]]; then
    echo "Помилка: об'єкт '$object_name' уже встановлено."
    exit 1
fi

touch -- "$object_name"
echo "Об'єкт '$object_name' успішно встановлено."
