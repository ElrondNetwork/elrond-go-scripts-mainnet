#!/bin/bash
set -e

#Make script aware of its location
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

source $SCRIPTPATH/config/variables.cfg
source $SCRIPTPATH/config/functions.cfg
source $SCRIPTPATH/config/menu_functions.cfg

#Check if there are newer versions of the scripts available
cd $SCRIPTPATH
CURRENT_SCRIPTS_COMMIT=$(git show | grep  -m 1 commit | awk '{print $2}')

if [ "$LATEST_SCRIPTS_COMMIT" != "$CURRENT_SCRIPTS_COMMIT" ]; then
  echo -e 
  read -p "You aren't running the current versions of the scripts. Are you sure you want to continue ? (Yy/Nn)" yn
  echo -e

  case $yn in
        [Yy]* ) ;;
        [Nn]* ) echo "Ok.Exiting."; exit;;
        * ) echo "Please answer Yy / Nn ..."; exit;;
    esac
fi

#See if the user has passed any command line arguments and if not show the menu
if [ $# -eq 0 ]
  then

  show_menu #Show all the menu options

  COLUMNS=12
  PS3="Please select an action:"
  options=("install" "observing_squad" "upgrade" "upgrade_proxy" "upgrade_squad" "remove_db" "start" "stop" "restart" "cleanup" "github_pull" "get_logs" "quit")


  select opt in "${options[@]}"
  do

  case $opt in

  'install')
    install
    echo -e
    read -n 1 -s -r -p "  Process finished. Press any key to continue..."
    clear
    show_menu
    ;;

  'observing_squad')
    observers
    echo -e
    read -n 1 -s -r -p "  Process finished. Press any key to continue..."
    clear
    show_menu
    ;;

  'upgrade')
    upgrade
    echo -e
    read -n 1 -s -r -p "  Process finished. Press any key to continue..."
    clear
    show_menu
    ;;

  'upgrade_squad')
    upgrade_squad
    echo -e
    read -n 1 -s -r -p "  Process finished. Press any key to continue..."
    clear
    show_menu
    ;;

  'upgrade_proxy')
    upgrade_proxy
    echo -e
    read -n 1 -s -r -p "  Process finished. Press any key to continue..."
    clear
    show_menu
    ;;

  'remove_db')
    remove_db
    echo -e
    read -n 1 -s -r -p "  Process finished. Press any key to continue..."
    clear
    show_menu
    ;;

  'start')
    start
    echo -e
    read -n 1 -s -r -p "  Process finished. Press any key to continue..."
    clear
    show_menu
    ;;

  'stop')
    stop
    echo -e
    read -n 1 -s -r -p "  Process finished. Press any key to continue..."
    clear
    show_menu
    ;;
  
  'restart')
    stop && start
    echo -e
    read -n 1 -s -r -p "  Process finished. Press any key to continue..."
    clear
    show_menu
    ;;

  'cleanup')
    cleanup
    echo -e
    read -n 1 -s -r -p "  Process finished. Press any key to continue..."
    clear
    show_menu
    ;;

  'github_pull')
    github_pull
    echo -e
    read -n 1 -s -r -p "  Process finished. Press any key to continue..."
    clear
    show_menu
    ;;

  'get_logs')
    get_logs
    echo -e
    read -n 1 -s -r -p "  Process finished. Press any key to continue..."
    clear
    show_menu
    ;;

  'quit')
    echo -e
    echo -e "${GREEN}---> Exiting scripts menu...${NC}"
    echo -e
    break
    ;;

  esac

  done

else

case "$1" in
'install')
  install
  ;;

'observing_squad')
  observers
  ;;

'upgrade')
  upgrade
  ;;

'upgrade_squad')
  upgrade_squad
  ;;

'upgrade_proxy')
  upgrade_proxy
  ;;

'remove_db')
  remove_db
  ;;

'start')
  start
  ;;

'stop')
  stop
  ;;

'restart')
  stop && start
  ;;

'cleanup')
  cleanup
  ;;

'github_pull')
  github_pull
  ;;

'get_logs')
  get_logs
  ;;
  
esac

fi
