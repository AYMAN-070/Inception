NAME = inception
COMPOSE_FILE = ./srcs/docker-compose.yml
DATA_PATH = /home/ayhammou/data

all: up
up:
	@mkdir -p $(DATA_PATH)/mariadb
	@mkdir -p $(DATA_PATH)/wordpress
	docker compose -f $(COMPOSE_FILE) up -d --build

down:
	docker compose -f $(COMPOSE_FILE) down


clean: down
	docker system prune -af

fclean: clean
	docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	sudo rm -rf $(DATA_PATH)/mariadb/*
	sudo rm -rf $(DATA_PATH)/wordpress/*

re: fclean all

.PHONY: all up down clean fclean re