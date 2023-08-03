function installJava {
    echo "Descargando Java..."
    wget -q --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "https://download.oracle.com/otn-pub/java/jdk/8u301-b09/d3c52aa6bfa54d3ca74e617f18309292/jdk-8u301-linux-x64.tar.gz" -P /tmp

    echo "Descomprimiendo Java..."
    tar -xzf /tmp/jdk-8u301-linux-x64.tar.gz -C /usr/local/

    echo "Configurando Java..."
    update-alternatives --install /usr/bin/java java /usr/local/jdk1.8.0_301/bin/java 1
    update-alternatives --install /usr/bin/javac javac /usr/local/jdk1.8.0_301/bin/javac 1
    update-alternatives --set java /usr/local/jdk1.8.0_301/bin/java
    update-alternatives --set javac /usr/local/jdk1.8.0_301/bin/javac
}