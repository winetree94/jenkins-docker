# Jenkins 공식 LTS 이미지 사용
FROM jenkins/jenkins:lts

# Root 계정으로 진행
USER root

# apt 패키지 리스트를 업데이트하고, Docker 설치 전에 필요한 패키지들을 설치
RUN apt-get update -qq \
 && apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common

# Docker 컨테이너에서 apt-key add - 사용시 경고창이 생성되므로 해당 메시지 비활성화
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn
# Docker GPG 키 컨테이너 apt에 추가
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# Apt 저장소에 docker 에서 제공하는 저장소 추가
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

# 패키지 리스트 업데이트
RUN apt-get update
# 도커 설치
RUN apt-get install docker-ce -y
# sudo 권한 없이 도커 명령어를 사용할 수 있게 권한 조정
RUN usermod -aG docker jenkins

# 도커 컴포즈 바이너리 다운로드 후 설치
RUN curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# 도커 컴포즈의 권한 설정
RUN chmod +x /usr/local/bin/docker-compose