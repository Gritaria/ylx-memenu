local isMenuOpen = false
local playerStatuses = {} -- Armazena status de todos os jogadores { [serverID] = { [part] = data } }
local textBackgroundEnabled = true -- Estado do fundo escuro nos textos 3D



-- Pega traduções do config
local Lang
if Config and Config.Translations then
    Lang = Config.Translations[Config.Language]
    if Lang then
        print("^2[ylx-memenu] Script iniciado | Idioma: " .. Config.Language .. "^7")
    else
        Lang = Config.Translations['PT']
        print("^2[ylx-memenu] Script iniciado | Idioma: PT (fallback)^7")
    end
else
    Lang = {
        menu_title = 'Menu',
        close = 'Fechar',
        clear = 'Limpar',
        cabeca = 'Cabeça',
        tronco = 'Tronco',
        mao_esq = 'Mão Esquerda',
        mao_dir = 'Mão Direita',
        pe_esq = 'Pé Esquerdo',
        pe_dir = 'Pé Direito',
        body_location = 'Local do Corpo',
        description = 'Descrição',
        description_placeholder = 'Ex: Fratura exposta...',
        display_time = 'Tempo de Exibição',
        visible_distance = 'Distância Visível',
        indicator_color = 'Cor do Indicador',
        confirm_button = 'Confirmar Status',
        no_status = 'Nenhum status ativo.',
        saved = 'SALVO'
    }
end

-- Mapeamento de Bones (Ossos) do RDR2
local boneMap = {
    ['cabeca'] = 21030,   -- skel_head
    ['tronco'] = 24860,   -- SKEL_Spine2
    ['cintura'] = 24860,   -- Usa tronco como base, mas com offset
    ['mao_esq'] = 34606,  -- skel_l_hand
    ['mao_dir'] = 22798,  -- skel_r_hand
    ['pe_esq'] = 45454,   -- skel_l_foot
    ['pe_dir'] = 33646    -- skel_r_foot
}

-- Offset vertical (Z) para cada bone (ajusta a altura do texto)
local boneZOffset = {
    ['cabeca'] = 0.2,
    ['tronco'] = 0.2,
    ['cintura'] = -0.15,   -- Offset negativo para ficar na altura da fivela
    ['mao_esq'] = 0.2,
    ['mao_dir'] = 0.2,
    ['pe_esq'] = 0.2,
    ['pe_dir'] = 0.2
}

-- Comando para abrir o menu
RegisterCommand('memenu', function()
    if not isMenuOpen then
        isMenuOpen = true
        SetNuiFocus(true, true)
        
        -- Envia configurações e traduções para NUI
        SendNUIMessage({ 
            action = 'open',
            config = Config and {
                maxTime = Config.MaxTime or 20,
                minTime = Config.MinTime or 3,
                defaultTime = Config.DefaultTime or 7,
                maxDistance = Config.MaxDistance or 25,
                minDistance = Config.MinDistance or 1,
                defaultDistance = Config.DefaultDistance or 10,
                defaultTextBackground = Config.DefaultTextBackground ~= nil and Config.DefaultTextBackground or true
            } or {
                maxTime = 20,
                minTime = 3,
                defaultTime = 7,
                maxDistance = 25,
                minDistance = 1,
                defaultDistance = 10,
                defaultTextBackground = true
            },
            translations = Lang
        })
    end
end)

-- Comando /me para texto rápido com configurações automáticas
-- Uso: /me texto (ou nome configurado em Config.MeCommandName)
-- Configurações automáticas: cor branca, fundo escuro, 7 segundos, 20 metros
if Config.EnableMeCommand then
    RegisterCommand(Config.MeCommandName or 'me', function(source, args)
        if #args == 0 then
            return
        end
        
        local text = table.concat(args, " ")
        
        -- Adiciona asteriscos se configurado como padrão
        if Config.DefaultAsterisks then
            text = "*" .. text .. "*"
        end
        
        -- Configurações automáticas do /me
        local meData = {
            text = text,
            color = "#FFFFFF",  -- Cor branca
            time = 7,           -- 7 segundos
            dist = 20,          -- 20 metros
            textBackground = true -- Fundo escuro ativado
        }
        
        -- Ativa o fundo escuro localmente (para garantir que está ativo)
        textBackgroundEnabled = true
        
        -- Envia para o servidor sincronizar com todos
        TriggerServerEvent('ylx-memenu:syncStatus', 'cintura', meData)
    end, false)
end

-- Callbacks da NUI
RegisterNUICallback('close', function(data, cb)
    isMenuOpen = false
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('updateStatus', function(data, cb)
    -- Envia para o servidor sincronizar com todos (Namespace atualizado)
    TriggerServerEvent('ylx-memenu:syncStatus', data.part, data.data)
    cb('ok')
end)

RegisterNUICallback('clearAll', function(data, cb)
    TriggerServerEvent('ylx-memenu:clearAll')
    cb('ok')
end)

RegisterNUICallback('setTextBackground', function(data, cb)
    textBackgroundEnabled = data.enabled
    cb('ok')
end)

-- Evento de Sincronização (Recebe do servidor)
RegisterNetEvent('ylx-memenu:receiveSync')
AddEventHandler('ylx-memenu:receiveSync', function(targetServerId, part, data)
    if not playerStatuses[targetServerId] then playerStatuses[targetServerId] = {} end
    
    if data == nil then
        -- Remove o status específico
        playerStatuses[targetServerId][part] = nil
    else
        -- Adiciona/Atualiza
        data.startTime = GetGameTimer() -- Marca quando começou para calcular o tempo
        playerStatuses[targetServerId][part] = data
    end
end)

RegisterNetEvent('ylx-memenu:receiveClear')
AddEventHandler('ylx-memenu:receiveClear', function(targetServerId)
    playerStatuses[targetServerId] = nil
end)


-- Loop de Renderização (Draw Text 3D)
Citizen.CreateThread(function()
    while true do
        local sleep = 500
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for serverId, statuses in pairs(playerStatuses) do
            local targetPlayer = GetPlayerFromServerId(serverId)
            
            if targetPlayer ~= -1 then
                local targetPed = GetPlayerPed(targetPlayer)
                
                -- Só renderiza se o jogador estiver no stream/perto
                if DoesEntityExist(targetPed) then
                    local targetCoords = GetEntityCoords(targetPed)
                    local distToTarget = #(playerCoords - targetCoords)

                    -- Verifica cada status desse jogador
                    for part, info in pairs(statuses) do
                        -- Checa Distância configurada
                        if distToTarget <= (info.dist or 10.0) then
                            sleep = 0 -- Ativa o frame se tiver algo pra desenhar
                            
                            -- Checa Tempo (se configurado)
                            local timePassed = (GetGameTimer() - info.startTime) / 1000
                            if timePassed <= (info.time or 7) then
                                -- Pega posição do osso
                                local boneId = boneMap[part]
                                local boneCoords = targetCoords -- Fallback
                                
                                if boneId then
                                    boneCoords = GetPedBoneCoords(targetPed, boneId, 0.0, 0.0, 0.0)
                                end
                                
                                -- Desenha o Texto com offset específico do bone
                                local zOffset = boneZOffset[part] or 0.2
                                DrawText3D(boneCoords.x, boneCoords.y, boneCoords.z + zOffset, info.text, info.color)
                            else
                                -- Tempo expirou, remove localmente pra economizar check
                                statuses[part] = nil
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

-- Função auxiliar para desenhar texto 3D no RedM
function DrawText3D(x, y, z, text, colorHex)
    local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)
    if onScreen then
        -- Converte HEX para RGB
        local r, g, b = HexToRGB(colorHex)
        
        SetTextScale(0.35, 0.35)
        SetTextFontForCurrentCommand(1) -- Fonte padrão legível
        SetTextColor(r, g, b, 255)
        SetTextCentre(1)
        SetTextDropshadow(1, 0, 0, 0, 200)
        
        -- Desenha fundo escuro se habilitado
        if textBackgroundEnabled then
            -- Calcula o tamanho aproximado do texto
            local textLength = string.len(text)
            local width = (textLength * 0.006) + 0.005 -- Largura mais compacta
            local height = 0.022 -- Altura mais justa
            
            -- Desenha retângulo de fundo (preto semi-transparente)
            DrawRect(_x, _y + 0.012, width, height, 0, 0, 0, 180)
        end
        
        DisplayText(CreateVarString(10, "LITERAL_STRING", text), _x, _y)
    end
end

function HexToRGB(hex)
    hex = hex:gsub("#","")
    return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
end