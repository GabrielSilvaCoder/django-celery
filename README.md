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

    Inicie o scheduler do Celery para agendar as tarefas:
    ```bash
    celery -A core beat -l INFO --scheduler django_celery_beat.schedulers:DatabaseScheduler


11. **Acessar o Django Admin**

    Após iniciar o servidor, acesse o painel de administração do Django em:
    ```bash
    http://localhost:8000/admin


12. **Adicionar uma Tarefa Periódica (Periodic Task)**

    Para programar a execução de uma ação, siga os passos abaixo:

    1.No painel de administração, navegue até a seção Periodic Tasks (disponível se você configurou o django_celery_beat).
    2.Clique em Add Periodic Task.
    3.Preencha os seguintes campos:
        Name: Um nome descritivo para a tarefa.
        Task: Escolha a tarefa registrada correspondente no Celery.
        Interval ou Crontab: Defina o intervalo ou cronograma de execução.
        Arguments: Adicione os argumentos necessários no formato JSON, como:
       ```bash
       ["NomeDaAção"]


13. **Monitorar Ações Salvas na Tabela stocks**

    Para acompanhar as ações capturadas e armazenadas no banco de dados:

    Utilize ferramentas como o Django Admin para visualizar os registros.
        Navegue até a seção correspondente ao modelo stocks.
        Verifique as entradas armazenadas com detalhes como nome da ação, valor capturado, e timestamp.
