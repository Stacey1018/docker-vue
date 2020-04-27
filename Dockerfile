# 使用node
FROM node:12.16.0

# 安装ngix
RUN apt-get clean 
RUN apt-get update \    
    && apt-get install -y nginx

# 指定工作目录
WORKDIR /app

# 当前目录下的所有文件拷贝到工作目录下
COPY . /app/

# 声明运行时容器提供的服务端口
EXPOSE 80

# 1.安装依赖
# 2.运行npm run build
# 3.将dist目录的所有文件拷贝到nginx的目录下
# 4.删除工作中目录，尤其node_modules 以减小镜像体积
#  为了减小镜像体积，尽可能将一些同类
RUN  npm install \
    && npm run build \
    && cp -r dist/* /var/www/html \
    && rm -rf /app
CMD ["nginx","-g","daemon off;"]
