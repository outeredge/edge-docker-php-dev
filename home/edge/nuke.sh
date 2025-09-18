#!/bin/bash

nuke() {
    read -r -p "Beni, is that you? (Y/n) " is_beni
    if [[ -z "$is_beni" || "$is_beni" =~ ^[Yy]$ ]]; then
        read -r -p "Beni....do you really need to nuke? (Y/n) " confirm_nuke
        if [[ -z "$confirm_nuke" || "$confirm_nuke" =~ ^[Yy]$ ]]; then
            $WEB_ROOT/bin/magento outeredge:nuke
        else
            echo "Nuke aborted. That was a close one."
        fi
    else
        $WEB_ROOT/bin/magento outeredge:nuke
    fi
}
