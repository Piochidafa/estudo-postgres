FROM maven:3-amazoncorretto-21-alpine as build

COPY . .

RUN mvn package

FROM maven:3-amazoncorretto-21-alpine as deploy

RUN addgroup --system desafioseplag && adduser --system --ingroup desafioseplag desafioseplag

COPY --from=build target/*.jar desafioseplag.jar

EXPOSE 8083

USER desafioseplag

ENTRYPOINT ["java", "-jar", "desafioseplag.jar"]

