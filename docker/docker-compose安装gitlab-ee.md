# docker-compose安装gitlab-ee以及优化方案

## 简略版

```yaml
version: '3.6'
services:
  web:
    image: 'gitlab/gitlab-ee:latest'   #下载慢可替换加速地址
    restart: always
    hostname: 'demo.com'   #此处建议填写访问域名
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        external_url 'http://127.0.0.1:8088'   #此处是gitlab访问地址填写域名，IP也可以
        gitlab_rails['time_zone'] = 'Asia/Shanghai'
        # Add any other gitlab.rb configuration here, each on its own line
        
    ports:
      - '8088:80'    #容器内80端口转发到主机8088端口
      - '8443:443'   #容器内443端口转发到主机8443端口
      - '222:22'   #容器内22端口转发到主机222端口
    volumes:
      - '$GITLAB_HOME/gitlab/config:/etc/gitlab'
      - '$GITLAB_HOME/gitlab/logs:/var/log/gitlab'
      - '$GITLAB_HOME/gitlab/data:/var/opt/gitlab'
 
 
    shm_size: '1g'   #官网默认64m，容器日志会出错建议增加
```

## 优化版

```yaml
version: '3.6'
services:
  web:
    image: 'gitlab/gitlab-ee:latest'
    restart: always
    hostname: 'demo.com'
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        external_url 'http://127.0.0.1:8088'
        gitlab_rails['time_zone'] = 'Asia/Shanghai'
        # Add any other gitlab.rb configuration here, each on its own line
        
        # 关闭电子邮件相关功能
        gitlab_rails['smtp_enable'] = false
        gitlab_rails['gitlab_email_enabled'] = false
        gitlab_rails['incoming_email_enabled'] = false
 
        # Terraform
        gitlab_rails['terraform_state_enabled'] = false
 
        # 使用情况统计
        gitlab_rails['usage_ping_enabled'] = false
        gitlab_rails['sentry_enabled'] = false
        grafana['reporting_enabled'] = false
 
        # 关闭容器仓库功能
        gitlab_rails['gitlab_default_projects_features_container_registry'] = false
        gitlab_rails['registry_enabled'] = false
        registry['enable'] = false
        registry_nginx['enable'] = false
 
        # 包仓库
        gitlab_rails['packages_enabled'] = false
        gitlab_rails['dependency_proxy_enabled'] = false
 
        # GitLab KAS
        gitlab_kas['enable'] = false
        gitlab_rails['gitlab_kas_enabled'] = false
 
        # Mattermost
        mattermost['enable'] = false
        mattermost_nginx['enable'] = false
 
        # Kerberos
        gitlab_rails['kerberos_enabled'] = false
        sentinel['enable'] = false
 
        # GitLab Pages
        gitlab_pages['enable'] = false
        pages_nginx['enable'] = false
 
        # 禁用 PUMA 集群模式
        puma['worker_processes'] = 0
        puma['min_threads'] = 1
        puma['max_threads'] = 2
 
        # 降低后台守护进程并发数
        sidekiq['max_concurrency'] = 5
 
        gitlab_ci['gitlab_ci_all_broken_builds'] = false
        gitlab_ci['gitlab_ci_add_pusher'] = false
 
        # 关闭监控
        prometheus_monitoring['enable'] = false
        alertmanager['enable'] = false
        node_exporter['enable'] = false
        redis_exporter['enable'] = false
        postgres_exporter['enable'] = false
        pgbouncer_exporter['enable'] = false
        gitlab_exporter['enable'] = false
        grafana['enable'] = false
        sidekiq['metrics_enabled'] = false
 
 
        # 配置 GitLab 处理内存的方式
        gitlab_rails['env'] = {
          'MALLOC_CONF' => 'dirty_decay_ms:1000,muzzy_decay_ms:1000'
        }
 
        gitaly['env'] = {
          'MALLOC_CONF' => 'dirty_decay_ms:1000,muzzy_decay_ms:1000'
        }
    ports:
      - '8088:80'
      - '8443:443'
      - '222:22'
    volumes:
      - '$GITLAB_HOME/gitlab/config:/etc/gitlab'
      - '$GITLAB_HOME/gitlab/logs:/var/log/gitlab'
      - '$GITLAB_HOME/gitlab/data:/var/opt/gitlab'
 
 
    shm_size: '1g'
```

## gitlab-ee高级功能

```yaml
version: '3.6'
services:
  web:
    image: 'gitlab/gitlab-ee:latest'
    restart: always
    hostname: 'demo.com'
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        external_url 'http://127.0.0.1:8088'
        gitlab_rails['time_zone'] = 'Asia/Shanghai'
        # Add any other gitlab.rb configuration here, each on its own line
        
        # 关闭电子邮件相关功能
        gitlab_rails['smtp_enable'] = false
        gitlab_rails['gitlab_email_enabled'] = false
        gitlab_rails['incoming_email_enabled'] = false
 
        # Terraform
        gitlab_rails['terraform_state_enabled'] = false
 
        # Usage Statistics
        gitlab_rails['usage_ping_enabled'] = false
        gitlab_rails['sentry_enabled'] = false
        grafana['reporting_enabled'] = false
 
        # 关闭容器仓库功能
        gitlab_rails['gitlab_default_projects_features_container_registry'] = false
        gitlab_rails['registry_enabled'] = false
        registry['enable'] = false
        registry_nginx['enable'] = false
 
        # 包仓库
        gitlab_rails['packages_enabled'] = false
        gitlab_rails['dependency_proxy_enabled'] = false
 
        # GitLab KAS
        gitlab_kas['enable'] = false
        gitlab_rails['gitlab_kas_enabled'] = false
 
        # Mattermost
        mattermost['enable'] = false
        mattermost_nginx['enable'] = false
 
        # Kerberos
        gitlab_rails['kerberos_enabled'] = false
        sentinel['enable'] = false
 
        # GitLab Pages
        gitlab_pages['enable'] = false
        pages_nginx['enable'] = false
 
        # 禁用 PUMA 集群模式
        puma['worker_processes'] = 0
        puma['min_threads'] = 1
        puma['max_threads'] = 2
 
        # 降低后台守护进程并发数
        sidekiq['max_concurrency'] = 5
 
        gitlab_ci['gitlab_ci_all_broken_builds'] = false
        gitlab_ci['gitlab_ci_add_pusher'] = false
 
        # 关闭监控
        prometheus_monitoring['enable'] = false
        alertmanager['enable'] = false
        node_exporter['enable'] = false
        redis_exporter['enable'] = false
        postgres_exporter['enable'] = false
        pgbouncer_exporter['enable'] = false
        gitlab_exporter['enable'] = false
        grafana['enable'] = false
        sidekiq['metrics_enabled'] = false
 
 
        # 配置 GitLab 处理内存的方式
        gitlab_rails['env'] = {
          'MALLOC_CONF' => 'dirty_decay_ms:1000,muzzy_decay_ms:1000'
        }
 
        gitaly['env'] = {
          'MALLOC_CONF' => 'dirty_decay_ms:1000,muzzy_decay_ms:1000'
        }
    ports:
      - '8088:80'
      - '8443:443'
      - '222:22'
    volumes:
      - '$GITLAB_HOME/gitlab/config:/etc/gitlab'
      - '$GITLAB_HOME/gitlab/logs:/var/log/gitlab'
      - '$GITLAB_HOME/gitlab/data:/var/opt/gitlab'
 
      - type: bind  
        source: /gitlab/license_key.pub   #这个是宿主机的地址
        target: /opt/gitlab/embedded/service/gitlab-rails/.license_encryption_key.pub  #这个是容器里配置文件的地址
      - type: bind  
        source: /gitlab/license.rb   #这个是宿主机的地址
        target: /opt/gitlab/embedded/service/gitlab-rails/ee/app/models/license.rb  #这个是容器里配置文件的地址
 
 
    shm_size: '1g'
```

## 查看密码

```shell
cat /etc/gitlab/initial_root_password
```

