#/bin/bash
#############################################
#                                           #
#        Script Limpeza do Docker           #
#        2023 - By: Diogo Pacheco           #
#                                           #
#############################################


#Função de animação de carregamento
spinner()
{
    local pid=$1
    local delay=0.15
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c] " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# Função para eliminar tudo
delete_tudo() {
  parar_containers
  delete_containers
  delete_images
  delete_volumes
  delete_networks
}

# Função para eliminar tudo mas não imagens
delete_tudo_imagens() {
  parar_containers
  delete_containers
  delete_volumes
  delete_networks
}

#Função para parar containers em execução
parar_containers() {
  if [[ $(docker ps -q) ]]; then
      echo -e "\e[31mStopping Containers...\e[0m"
      if docker stop $(docker ps -q) >/dev/null 2>&1 & spinner $!; then
          echo -e "\e[32mStop Conteiners Done..\e[0m"
      else
          echo -e "\e[31mThere are no running containers to stop.\e[0m"
      fi
  else
      # There are no containers to stop
      echo -e "\e[31mThere are no running containers to stop.\e[0m"
  fi
}

eliminar_quasetudo_imagens() {
  eliminar_containers
  eliminar_volumes
  eliminar_networks
}

# Função para eliminar containers
delete_containers() {
  if [ $(docker ps -aq | wc -l) -gt 0 ]; then
    echo -e "\e[31mDeleting Containers...\e[0m"
    docker rm $(docker ps -aq) >/dev/null 2>&1 & spinner $!
    echo -e "\e[32mContainers Deleted\e[0m"
  else
    echo -e "\e[31mThere are no containers to delete!\e[0m"
  fi
}

# Função para eliminar imagens
delete_images() {
  if [ $(docker image ls -q | wc -l) -gt 0 ]; then
    echo "Deleting images"
    docker rmi -f $(docker image ls -q) >/dev/null 2>&1 & spinner $!
    echo -e "\e[32mImages Deleted!\e[0m"
  else
    echo -e "\e[31mThere are no images to delete!\e[0m"
  fi
}

# Função para eliminar volumes
delete_volumes() {
  if [ $(docker volume ls -q | wc -l) -gt 0 ]; then
    echo "Deleting volumes"
    docker volume remove -f $(docker volume ls -q) & spinner $!
    echo -e "\e[32mVolumes Deleted!\e[0m"
  else
    echo -e "\e[31mThere are no volumes to delete\e[0m"
  fi
}

# Função para eliminar networks
delete_networks() {
  if [ $(docker network ls -q | wc -l) -gt 0 ]; then
    echo -e "\e[31mDeleting NetWorks...\e[0m"
    docker network rm $(docker network ls -q) >/dev/null 2>&1
    echo -e "\e[32mNetworks Deleted!\e[0m"
  else
    echo "There are no networks to delete!"
    echo -e "\e[31mThere are no networks to delete!\e[0m"
  fi
}

sair() {
  echo -e "\e[31mSaindo.....\e[0m"
}

# Limpar o terminal
clear

# Perguntar ao utilizador o que é para eliminar
echo -e "\e[31m==============================\e[0m"
echo -e "\e[31mWhat you want to Delete?\e[0m"
echo -e "\e[31m==============================\e[0m"
echo -e "\e[1m1. Everything\e[0m"
echo -e "\e[1m2. Everything but not images\e[0m"
echo -e "\e[1m3. Images\e[0m"
echo -e "\e[1m4. Volumes\e[0m"
echo -e "\e[1m5. Networks\e[0m"
echo -e "\e[1m6. Containers\e[0m"
echo -e "\e[1m7. Exit\e[0m"
echo -e "\e[31m===============\e[0m"

# Ler a opção do utilizador
read -p "Enter your choice (1-7): " choice

# Executar a função correspondente à opção escolhida pelo utilizador
case $choice in
  1)
    delete_tudo
    ;;
  2)
    delete_tudo_imagens
    ;;
  3)
    delete_images
    ;;
  4)
    delete_volumes
    ;;
  5)
    delete_networks
    ;;
  6)
    delete_containers

    ;;
  7)
    sair
    ;;
  *)
    echo "Invalid choice. Exiting..."
    ;;
esac

# Fim do script
echo
echo -e "\e[31m==============================\e[0m"
echo -e "\e[31mDone!\e[0m"