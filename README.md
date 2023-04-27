# Limpeza de Docker Script

Este é um script em shell para limpar o ambiente do Docker, permitindo a eliminação de containers, imagens, volumes e networks.

## Uso

O script permite que escolher o que se deseja eliminar através de um questionário interativo. Que pode ser entre as seguintes opções:

1. **Tudo**: Essa opção eliminará todos os containers, imagens, volumes e networks.
2. **Imagens**: Essa opção eliminará todas as imagens Docker.
3. **Volumes**: Essa opção eliminará todos os volumes Docker.
4. **Networks**: Essa opção eliminará todas as networks Docker.
5. **Containers**: Essa opção eliminará todos os containers Docker.
6. **Sair**: Essa opção encerrará o script.

## Requisitos

- Docker instalado e configurado no sistema.

## Notas

- Certifique-se de ter permissões de execução para o script (`chmod +x script.sh`).
- Este script foi criado para simplificar a limpeza do ambiente Docker. Certifique-se de entender as ações que serão executadas antes de selecionar a opção "Tudo" para evitar a perda de dados ou recursos importantes.
