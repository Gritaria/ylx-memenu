# ylx-memenu

RedM script to display 3D text status on player body parts.

> ⚠️ **IMPORTANT**: If your framework already has a `/me` command, you must either disable it OR change the command name in `config.lua` to avoid conflicts.

---

## 🇺🇸 English

### What does it do?
Generates customizable 3D text attached to different body parts of players, visible to nearby players. Perfect for roleplaying injuries, statuses, or emotes.

### Commands
- **`/me [text]`** - Quick display at waist (white, 7s, 20m)
- **`/memenu`** - Opens full configuration menu

### Body Locations
- Head
- Torso  
- Waist
- Left/Right Hand
- Left/Right Foot

### Menu Options
- **Description:** Text to display
- **Display Time:** 3-60 seconds (configurable max in `config.lua`)
- **Visible Distance:** 1-25 meters (configurable max in `config.lua`)
- **Color:** Predefined colors + custom picker
- **Dark Background:** Toggle text background
- **Asterisks:** Auto-add *text*

### Available Settings (`config.lua`)
- **Language:** PT or EN
- **Time Limits:** Min, max, and default display time
- **Distance Limits:** Min, max, and default visible distance
- **Default Options:** Text background, asterisks
- **Command Settings:** Enable/disable `/me`, change command name

### Installation
1. Place `ylx-memenu` in your resources folder
2. Add `ensure ylx-memenu` to `server.cfg`
3. Edit `config.lua` if needed
4. Restart server

---

## 🇧🇷 Português

### O que faz?
Gera texto 3D customizável anexado em diferentes partes do corpo dos jogadores, visível para jogadores próximos. Perfeito para RP de ferimentos, status ou emotes.

### Comandos
- **`/me [texto]`** - Exibição rápida na cintura (branco, 7s, 20m)
- **`/memenu`** - Abre menu completo de configuração

### Locais do Corpo
- Cabeça
- Tronco
- Cintura
- Mão Esquerda/Direita
- Pé Esquerdo/Direito

### Opções do Menu
- **Descrição:** Texto a ser exibido
- **Tempo de Exibição:** 3-60 segundos (máximo configurável no `config.lua`)
- **Distância Visível:** 1-25 metros (máximo configurável no `config.lua`)
- **Cor:** Cores predefinidas + seletor personalizado
- **Fundo Escuro:** Alternar fundo nos textos
- **Asteriscos:** Auto-adicionar *texto*

### Configurações Disponíveis (`config.lua`)
- **Idioma:** PT ou EN
- **Limites de Tempo:** Mín, máx e padrão de exibição
- **Limites de Distância:** Mín, máx e padrão de visibilidade
- **Opções Padrão:** Fundo nos textos, asteriscos
- **Configurações do Comando:** Habilitar/desabilitar `/me`, mudar nome do comando

### Instalação
1. Coloque `ylx-memenu` na pasta de resources
2. Adicione `ensure ylx-memenu` no `server.cfg`
3. Edite `config.lua` se necessário
4. Reinicie o servidor

---

##  Author / Autor
**yLx**
