FROM  ubuntu AS priya
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install openjdk-17-jdk -y
RUN apt install maven -y
RUN apt install git -y
RUN git clone https://github.com/apriyanka109/vprofile-project.git
WORKDIR /vprofile-project
RUN mvn package

# Use the official Tomcat image
FROM tomcat:9-jdk11

# Copy the WAR file from the target directory into Tomcat's webapps folder
COPY target/*.war /usr/local/tomcat/webapps/

# Apply permissions to the copied WAR file(s)
RUN chmod 755 /usr/local/tomcat/webapps/*.war

# Expose the Tomcat default port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
