all: 
	mkdir -p /home/pmaimait/data/mariadb
	mkdir -p /home/pmaimait/data/wordpress
	docker compose -f ./srcs/docker-compose.yml build
	docker compose -f ./srcs/docker-compose.yml up -d

logs:
	docker logs wordpress
	docker logs mariadb
	docker logs nginx

clean:
	docker container stop nginx mariadb wordpress 2> /dev/null || true;
	docker network rm inception 2> /dev/null || true;
	@docker system prune -af

fclean: clean
	@sudo rm -rf /home/pmaimait/data/mariadb/*
	@sudo rm -rf /home/pmaimait/data/wordpress/*
	

re: fclean all

.Phony: all logs clean fclean