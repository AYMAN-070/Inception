NAME = inception
COMPOSE_FILE = ./srcs/docker-compose.yml
DATA_PATH = /home/ayhammou/data

up:
	@sudo mkdir -p $(DATA_PATH)/mariadb
	@sudo mkdir -p $(DATA_PATH)/wordpress
	docker compose -f $(COMPOSE_FILE) up -d --build

down:
	docker compose -f $(COMPOSE_FILE) down

# clean just containers, network and images
clean: 
	docker compose -f $(COMPOSE_FILE) down --rmi all -v

# clean and delete all files on the disk
fclean: clean
	sudo rm -rf $(DATA_PATH)/mariadb/*
	sudo rm -rf $(DATA_PATH)/wordpress/*

re: fclean all

.PHONY: up down clean fclean re