#!/usr/bin/env fish

# Node names fijos (obtenidos con wpctl inspect)
set speaker_node "alsa_output.pci-0000_0a_00.6.iec958-stereo"
set headset_node "alsa_output.usb-MediaTek_Inc_Razer_BlackShark_V2_HS_2.4_0000000000000000-00.analog-stereo"

# Buscar ID dinámicamente usando el node.name
function get_id_from_node_name
    set node_name $argv[1]
    for id in (seq 1 100)
        set match (wpctl inspect $id ^/dev/null | grep -F "node.name = \"$node_name\"")
        if test -n "$match"
            echo $id
            return
        end
    end
end

# Obtener ID actual del sink predeterminado
set current_node (wpctl status | grep 'Audio/Sink' -A 5 | grep -o 'alsa_output[^ ]*')

# Detectar cuál usar
if test "$current_node" = "$headset_node"
    set speaker_id (get_id_from_node_name $speaker_node)
    wpctl set-default $speaker_id
    notify-send "Audio Output" "🎧 → 🔊 Speakers"
else if test "$current_node" = "$speaker_node"
    set headset_id (get_id_from_node_name $headset_node)
    wpctl set-default $headset_id
    notify-send "Audio Output" "🔊 → 🎧 Headset"
else
    echo "Audio Output" "⚠️ Output no reconocido: $current_node"
    notify-send "Audio Output" "⚠️ Output no reconocido: $current_node"
end
