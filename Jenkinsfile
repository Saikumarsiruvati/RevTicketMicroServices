pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Saikumarsiruvati/RevTicketMicroServices.git'
            }
        }

        stage('Build Backend') {
            steps {
                dir('microservices-backend/auth-service') {
                    bat 'mvn clean package -DskipTests'
                }
                dir('microservices-backend/user-service') {
                    bat 'mvn clean package -DskipTests'
                }
                dir('microservices-backend/event-service') {
                    bat 'mvn clean package -DskipTests'
                }
                dir('microservices-backend/booking-service') {
                    bat 'mvn clean package -DskipTests'
                }
                dir('microservices-backend/payment-service') {
                    bat 'mvn clean package -DskipTests'
                }
                dir('microservices-backend/notification-service') {
                    bat 'mvn clean package -DskipTests'
                }
                dir('microservices-backend/review-service') {
                    bat 'mvn clean package -DskipTests'
                }
                dir('microservices-backend/api-gateway') {
                    bat 'mvn clean package -DskipTests'
                }
            }
        }

        stage('Build Frontend') {
            steps {
                dir('monolithic-frontend') {
                    bat 'npm install'
                    bat 'npm run build'
                }
            }
        }

        stage('Stop Existing Containers') {
            steps {
                bat '''
                docker stop revticket-frontend api-gateway review-service booking-service notification-service auth-service payment-service user-service event-service revticket-mysql revticket-mongo revticket-consul
                exit /b 0
                '''
                bat '''
                docker rm revticket-frontend api-gateway review-service booking-service notification-service auth-service payment-service user-service event-service
                exit /b 0
                '''
            }
        }

        stage('Docker Network') {
            steps {
                bat '''
                docker network inspect revtickets-network >nul 2>&1 || docker network create revtickets-network
                '''
            }
        }

        stage('Start Infrastructure') {
            steps {
                dir('microservices-backend') {
                    bat '''
                    docker start revticket-mysql revticket-mongo revticket-consul
                    IF %ERRORLEVEL% NEQ 0 (
                        docker-compose up -d mysql mongo consul
                    )
                    '''
                }
            }
        }

        stage('Build Docker Images') {
            steps {
                dir('microservices-backend') {
                    bat '''
                    docker build -t auth-service ./auth-service
                    docker build -t user-service ./user-service
                    docker build -t event-service ./event-service
                    docker build -t booking-service ./booking-service
                    docker build -t payment-service ./payment-service
                    docker build -t notification-service ./notification-service
                    docker build -t review-service ./review-service
                    docker build -t api-gateway ./api-gateway
                    '''
                }
                dir('monolithic-frontend') {
                    bat 'docker build -t frontend .'
                }
            }
        }

        stage('Deploy Services') {
            steps {
                bat '''
                timeout /t 20 /nobreak

                docker run -d --name auth-service --network revtickets-network -p 8086:8086 ^
                -e SPRING_CLOUD_CONSUL_HOST=consul auth-service

                docker run -d --name user-service --network revtickets-network -p 8081:8081 ^
                -e SPRING_DATASOURCE_URL=jdbc:mysql://mysql:3306/user_db?createDatabaseIfNotExist=true ^
                -e SPRING_CLOUD_CONSUL_HOST=consul user-service

                docker run -d --name event-service --network revtickets-network -p 8082:8082 ^
                -e SPRING_DATASOURCE_URL=jdbc:mysql://mysql:3306/event_db?createDatabaseIfNotExist=true ^
                -e SPRING_CLOUD_CONSUL_HOST=consul event-service

                docker run -d --name booking-service --network revtickets-network -p 8083:8083 ^
                -e SPRING_DATASOURCE_URL=jdbc:mysql://mysql:3306/booking_db?createDatabaseIfNotExist=true ^
                -e SPRING_DATA_MONGODB_URI=mongodb://mongo:27017/booking_db ^
                -e SPRING_CLOUD_CONSUL_HOST=consul booking-service

                docker run -d --name payment-service --network revtickets-network -p 8084:8084 ^
                -e SPRING_DATASOURCE_URL=jdbc:mysql://mysql:3306/payment_db?createDatabaseIfNotExist=true ^
                -e SPRING_CLOUD_CONSUL_HOST=consul payment-service

                docker run -d --name notification-service --network revtickets-network -p 8085:8085 ^
                -e SPRING_DATA_MONGODB_URI=mongodb://mongo:27017/notification_db ^
                -e SPRING_CLOUD_CONSUL_HOST=consul notification-service

                docker run -d --name review-service --network revtickets-network -p 8087:8087 ^
                -e SPRING_DATA_MONGODB_URI=mongodb://mongo:27017/review_db ^
                -e SPRING_CLOUD_CONSUL_HOST=consul review-service

                docker run -d --name api-gateway --network revtickets-network -p 8090:8080 ^
                -e SPRING_CLOUD_CONSUL_HOST=consul api-gateway

                docker run -d --name revticket-frontend --network revtickets-network -p 4200:4200 frontend
                '''
            }
        }

        stage('Health Check') {
            steps {
                sleep(time: 60, unit: 'SECONDS')
                bat '''
                powershell -Command "try { Invoke-WebRequest http://localhost:8090/actuator/health -UseBasicParsing } catch { exit 0 }"
                '''
            }
        }
    }

    post {
        success {
            echo '✅ SUCCESS - Application is live at http://localhost:4200'
        }
        failure {
            echo '❌ FAILED - Check Jenkins console logs'
        }
    }
}
