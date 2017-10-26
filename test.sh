while_var=true
while [ "$while_var" = true ]
do
  echo ''
  cowsay Salut toi, je suis une vache au cas ou !...
  echo '================================================================================'
  echo -e '\033[34;1;4;5;7m Salut saisis ton choix \033[0m'
  echo '================================================================================'
  echo ''
  echo '1. Veux-tu installer  le logiciel virtualbox et/ou Vagrant'
  echo ''
  echo '2. Créer une vagrant '
  echo ''
  echo '3. Lancer une Vagrant'
  echo ''
  echo '4. Voir les machines virtuels ouvertes'
  echo ''
  echo "Saisis 'q' pour quitter"
  echo ''
  read var_choice
  case "$var_choice" in
    "1")
    #Choix pour l'installation de vagrant ou virtualbox
    echo ''
    echo '================================================================================'
    echo -e '\033[34;1;4;5;7m Installation  des logiciels virtualbox et/ou Vagrant \033[0m'
    echo '================================================================================'
    echo ''
    echo -e '\033[34;1;4;5;7m -Quel distribution voulez-vous installer ? \033[0m'
    echo ''
    OPTIONSBIS="virtualbox vagrant"
        select optBis in $OPTIONSBIS; do
        if [ "$optBis" = "virtualbox" ]
        then
        sudo apt-get install virtualbox 5.1  2> errors.sh || echo -e "\033[41m L'installation à Déjà été faite de virtualbox \033[0m"
          break;
        elif [ "$optBis" = "vagrant" ]
        then
          sudo apt-get install Vagrant  2> errors.sh || echo -e "\031[41m L'installation à Déjà été faite de Vagrant \031[0m"
          break;
        fi
        done
        ;;
    "2")
        echo ''
        echo '================================================================================'
        echo -e '\033[34;1;4;5;7m Creation de la vagrant \033[0m'
        echo '================================================================================'
        echo ''
        # On crée le dossier Vagrant
        mkdir Vagrant
        # On rentre dans le repertoire
        cd Vagrant
        # On demande a l'utilisateur le nom de dossier
        echo ''
        echo -e '\033[34;1;4;5;7m- Comment souhaitez-vous appeler votre dossier ? \033[0m'
        echo ''
        read var_dossier
        # On rente dans le dossier
        mkdir "$var_dossier"
        # On demarre l'initialisation de Vagrant
        vagrant init
        # On demande quelle box l'user veut utilisateur
        echo ''
        echo -e '\033[34;1;4;5;7m - Quel distribution voulez-vous installer ? \033[0m'
        echo ''
        OPTIONSBIS="Xenial XenialBis"
            select optBis in $OPTIONSBIS; do
            if [ "$optBis" = "Xenial" ]
            then
              sed -i -e "s/config.vm.box = \"base\"/config.vm.box =\"xenial.box\"/g" Vagrantfile
              sed -i -e "s/# config.vm.network \"private_network\", ip: \"192.168.33.10\"/config.vm.network \"private_network\", ip: \"192.168.33.10\"/g" Vagrantfile
              # On modifie le delimiteur par un '=' pour pouvoir inclure les '/' dans notre action
              sed -i -e "s=# config.vm.synced_folder \"../data\", \"/vagrant_data\"=config.vm.synced_folder \"$var_dossier\", \"/var/www/\"=g" Vagrantfile
              break;
            elif [ "$optBis" = "XenialBis" ]
            then
              sed -i -e "s/config.vm.box =\"base\"/config.vm.box =\"xenial.box\"/g" Vagrantfile
              sed -i -e "s/# config.vm.network \"private_network\", ip: \"192.168.33.10\"/ config.vm.network \"private_network\", ip: \"192.168.33.10\"/g" Vagrantfile
              sed -i -e "s=# config.vm.synced_folder \"../data\", \"/vagrant_data\"=config.vm.synced_folder \"$var_dossier\", \"/var/www/\"=g" Vagrantfile
              break;
            fi
            done
            echo ''
            echo '================================================================================'
            echo -e '\033[42;1;4;5;7m Votre machine vituel est prête ! \033[0m'
            echo '================================================================================'
            echo ''
        ;;

    "3")
        echo ''
        echo '================================================================================'
          echo -e '\033[34;1;4;5;7m Lancement de la vagrant \033[0m '
        echo '================================================================================'
        echo ''
        # On up notre vagrant
        vagrant up 2> errors.sh || echo -e "HOP HOP HOP HOP"
        # On se connecte
        vagrant ssh
        exit
        ;;
      "4")
        echo ''
        echo '================================================================================'
        echo -e '\033[34;1;4;5;7m Afficher le nombre de machine virtuel qui fonctionne ... \033[0m '
        echo '================================================================================'
        echo ''
        echo ''
        echo ''
        echo ''
        # On affiche les machines virtuel en état de marche
        vagrant global-status
        sleep 3
        ;;
    "q")
        echo ''
        echo '=================================='
          echo -e '\033[34;1;4;5;7m Cest tout pour aujourdhui ... \033[0m '
        echo '=================================='
        echo ''
        while_var=false
  esac
done
