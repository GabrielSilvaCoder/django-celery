# Sistema de Agendamento e Execução de Tarefas com Django e Celery

Este projeto implementa um sistema de agendamento e execução de tarefas em tempo real para capturar os valores de ações financeiras e armazená-los no banco de dados. Utilizando **Django** para a construção do aplicativo e **Celery** para o gerenciamento das tarefas assíncronas.

## Instruções de Configuração e Execução

1. **Criar o ambiente virtual**
   
   No diretório raiz do projeto, execute o seguinte comando para criar um ambiente virtual:
   ```bash
   python -m venv venv
   ```

2. **Ativar o ambiente virtual**

   - **No Windows:**
     ```bash
     venv\Scripts\activate
     ```
   - **No Linux/MacOS:**
     ```bash
     source venv/bin/activate
     ```

3. **Instalar as dependências**

   Com o ambiente virtual ativado, instale as dependências do projeto:
   ```bash
   pip install -r requirements.txt
   ```

4. **Rodar as migrações do banco de dados**

   Execute as migrações para criar as tabelas do banco de dados:
   ```bash
   python manage.py migrate
   ```

5. **Criar o superusuário**

   Crie um superusuário para acessar o painel de administração do Django:
   ```bash
   python manage.py createsuperuser
   ```

6. **Executar o servidor Django**

   Inicie o servidor Django localmente:
   ```bash
   python manage.py runserver
   ```

7. **Certificar-se de que o Docker está instalado**

   Verifique se o Docker está instalado no seu sistema. Caso não tenha, [instale o Docker](https://docs.docker.com/get-docker/).

8. **Criar a imagem do RabbitMQ no Docker**

   Para executar o RabbitMQ, crie a imagem do RabbitMQ com o comando:
   ```bash
   docker run -d --name rabbitmq -p 15672:15672 -p 5672:5672 rabbitmq:3-management
   ```

9. **Executar o worker do Celery**

   Com o Docker rodando o RabbitMQ, inicie o worker do Celery para processar as tarefas assíncronas:
   ```bash
   celery -A core worker -l INFO
   ```

10. **Executar o scheduler do Celery**

    Por fim, inicie o scheduler do Celery para agendar as tarefas:
    ```bash
    celery -A core beat -l INFO --scheduler django_celery_beat.schedulers:DatabaseScheduler