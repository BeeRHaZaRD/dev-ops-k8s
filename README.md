# dev-ops-k8s

### Ход работы:
1. Создал директорию static с файлом hello.html
2. Создал Dockerfile, в котором:
    1. Обеспечивается запуск web-сервера от пользователя с uid 1001
    2. Создается рабочая директория /app
    3. Копируются файлы (hello.html) из директории static в /app
    4. Публикуется порт 8000
    5. Запускается web-сервер командой `python -m http.server 8000`
3. Собрал Docker image: `docker build -t beerhazard/webapp:1.0.0 .`
4. Запустил container из созданного image: `docker run -ti --rm -p 8000:8000 beerhazard/webapp:1.0.0`
5. Проверил корректность работы сервера: `curl http://127.0.0.1:8000/hello.html`
6. Запушил Docker image на Docker Hub: `docker push beerhazard/webapp:1.0.0`
7. Создал Kubernetes Deployment manifest, запускающий container из созданного image, в котором:
    1. Указал 2 реплики
    2. Добавил Readiness и Liveness HTTP пробы с path='/'
8. Применил manifest: `kubectl apply -f deployment.yaml --namespace default`
9. Обеспечил доступ к web-приложению внутри кластера: `kubectl port-forward --address 0.0.0.0 deployment/web 8080:8000`
10. Проверил корректность работы web-приложения
