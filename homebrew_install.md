# 1
# 先去安装iterm2

# 2 / 这一步可能会提示安装git，正好后面都比较依赖git，或者先安装xcode里面会带git一般
# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


#### HomeBrew 安装

___

- 获取并安装homebrew(这个是一个国内的安装脚本，还是不错的)

```bash
1. 先安装Xcode，并记得打开同意里面的开发条款
2. 命令行输入下面命令，按步骤安装，中间可能会提示安装你电脑中缺少的必要的东西
sh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"
```



- 安装mysql
  1. brew install mysql
  
  2. mysql_secure_installation
  
  3. 按提示配置，记住用户名是root，密码自己设置
  
  4. 使用mysq -u root -p 进行测试
  
  5. 解决链接认证不通过问题：
  
     ```text
     终端登录mysql，执行：
     ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'yourpassword';
     ```
  
     
  
- maven

  - Brew install maven

  - 国内更换maven的镜像为ali云, 替换conf/setting.xml, 可使用brew info maven 查看mac上brew安装的目录

    ```xml
    <mirrors>
       <mirror>
        <id>aliyunmaven</id>
        <mirrorOf>*</mirrorOf>
        <name>阿里云公共仓库</name>
        <url>https://maven.aliyun.com/repository/public</url>
       </mirror>  
     </mirrors>
    ```

  - 在idea中Build->maven中更改为下载的maven，不使用默认的maven

   
