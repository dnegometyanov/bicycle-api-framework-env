## Bicycle API framework environment

## Installation instructions

1. Checkout all test task repositories (`bicycle-api-framework`, `bicycle-api-framework-env`)

2. Change dir to `bicycle-env`

3. Run `docker-compose up --build` (further, if no changes were made to env, you can use just `docker-compose up`, also there is an option `-d` for background mode)

4. Run `docker ps`, it  should display two running containers, something like

```
CONTAINER ID        IMAGE                                  COMMAND                  CREATED             STATUS              PORTS                                            NAMES

0c407244edc5        bicycleapiframeworkenv_web             "nginx -g 'daemon ..."   11 minutes ago      Up 11 minutes       0.0.0.0:8080->80/tcp                             bicycleapiframeworkenv_web_1

8d074bdbbf96        bicycleapiframeworkenv_php             "docker-php-entryp..."   11 minutes ago      Up 11 minutes       9000/tcp                                         bicycleapiframeworkenv_php_1

7a2935d16315        bicycleapiframeworkenv_logstash        "/bin/sh -c 'logst..."   11 minutes ago      Up 11 minutes       0.0.0.0:5000->5000/tcp, 0.0.0.0:5000->5000/udp   bicycleapiframeworkenv_logstash_1

b5de63d05192        bicycleapiframeworkenv_kibana          "/bin/sh -c kibana..."   11 minutes ago      Up 11 minutes       0.0.0.0:5601->5601/tcp                           bicycleapiframeworkenv_kibana_1

2bb1119c5a1d        phpmyadmin/phpmyadmin                  "/run.sh phpmyadmin"     11 minutes ago      Up 11 minutes       0.0.0.0:9090->80/tcp                             bicycleapiframeworkenv_phpmyadmin_1

00b682ca6459        bicycleapiframeworkenv_elasticsearch   "/bin/sh -c elasti..."   11 minutes ago      Up 11 minutes       0.0.0.0:9200->9200/tcp, 0.0.0.0:9300->9300/tcp   bicycleapiframeworkenv_elasticsearch_1

3d4836754a0f        mysql                                  "docker-entrypoint..."   11 minutes ago      Up 11 minutes       0.0.0.0:3306->3306/tcp                           bicycleapiframeworkenv_mysql_1
```

5. Using the container name of php container, for example in the case upper it is `bicycleapiframeworkenv_php_1`

    Run `docker exec -it bicycleapiframeworkenv_php_1 composer install`

    This should install composer dependencies for the project.

6. Import project mysql database (use your container name instead of `bicycleapiframeworkenv_php_1` if needed):

Import `/db-schema/schema.sql` to `bicycleapiframeworkenv_mysql_1` container via `PHPMyadmin`

Or

Put test OHT mysql database dump to `/db-schema/schema.sql` inside `bicycleapiframeworkenv_mysql_1` container and import it:

```
docker exec -i bicycleapiframeworkenv_mysql_1 bash <<'EOF'
mysql -uroot -p123456 -e 'DROP DATABASE bicycle'
mysql -uroot -p123456 -e 'CREATE DATABASE bicycle'
mysql --init-command="SET SESSION FOREIGN_KEY_CHECKS=0;" -uroot -p123456 bicycle < /var/dump/schema.sql
exit
EOF
```

#### Containers

`docker-compose.yml` containers explanation:

`web` - container with nginx for backend

`php` - container with php-fpm for backend

`mysql` - container with local mysql database

#### Entry points

Backend api `http://localhost:8080/`

curl request to api example:

```
curl -X POST \
  http://localhost:8080/transaction/test@example.com \
  -H 'authorization: Basic aW5ub3ZlY3M6aW5ub3ZlY3M=' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -d '{
	"amount": 123.45
}'
```