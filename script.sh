#!/usr/bin/env bash

echo "Main Menu"
choices=( 'copy' 'exit' )
select choice in "${choices[@]}"; do
  [[ -n $choice ]] || { echo "Invalid choice." >&2; continue; }
  case $choice in
    copy)
      echo "Copying..."
      ;;
    exit)
       echo "Exiting. "
       exit 0
  esac 
  break
done
