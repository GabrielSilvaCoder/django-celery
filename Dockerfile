FROM python:3.10-slim

WORKDIR /app

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Criar ambiente virtual
RUN python3 -m venv /venv

# Ativar o ambiente virtual
ENV PATH="/venv/bin:$PATH"

# Instalar dependências do projeto
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copiar os arquivos do projeto
COPY . /app/

CMD ["bash"]
