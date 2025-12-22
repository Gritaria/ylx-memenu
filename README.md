# ylx-memenu

Status display system for RedM with `/me` and `/memenu` commands.

> ⚠️ **IMPORTANT**: If your framework already has a `/me` command, you must either disable it in the framework OR change the command name in `config.lua` to avoid conflicts.

---

## 🇺🇸 English

### Commands

| Command | Description |
|---------|-------------|
| `/me [text]` | Quick text display at waist with automatic settings |
| `/memenu` | Opens the full NUI menu for configuration |

### /me Command
Automatic settings applied:
- **Color:** White (#FFFFFF)
- **Background:** Dark enabled
- **Time:** 7 seconds
- **Distance:** 20 meters
- **Location:** Waist

### /memenu Menu

The menu offers the following options:

#### Body Locations
- Head
- Torso
- Waist
- Left Hand
- Right Hand
- Left Foot
- Right Foot

#### Settings
- **Description:** Text field for the status
- **Display Time:** Adjustable slider (3-20 seconds)
- **Visible Distance:** Adjustable slider (1-25 meters)
- **Indicator Color:** Pre-defined colors + free picker
- **Dark Background:** Checkbox to enable/disable text background
- **Asterisks:** Checkbox to add *text* automatically

### Configuration

Edit `config.lua` to customize:

```lua
-- Language: 'PT' (Portuguese) or 'EN' (English)
Config.Language = 'PT'

-- Time limits (seconds)
Config.MaxTime = 20
Config.MinTime = 3
Config.DefaultTime = 7

-- Distance limits (meters)
Config.MaxDistance = 25
Config.MinDistance = 1
Config.DefaultDistance = 10

-- Default options
Config.DefaultTextBackground = true  -- Dark background
Config.DefaultAsterisks = true       -- Asterisks (*text*)

-- /me Command Settings
Config.EnableMeCommand = true        -- true = Enable /me | false = Only /memenu
Config.MeCommandName = 'me'          -- Change to avoid conflicts with framework
```

### Installation

1. Place the `ylx-memenu` folder in your resources folder
2. Add `ensure ylx-memenu` to your server.cfg
3. Configure `config.lua` as needed
4. **⚠️ About /me command:**
   - If your framework (RSG, VORP, etc.) already has a `/me` command, you have 3 options:
     - **Option A:** Disable the framework's `/me` command
     - **Option B:** Change `Config.MeCommandName` to something else (e.g., `'mee'`, `'eme'`, `'status'`)
     - **Option C:** Set `Config.EnableMeCommand = false` to use only `/memenu`
5. Restart the server

---

## 🇧🇷 Português

### Comandos

| Comando | Descrição |
|---------|-----------|
| `/me [texto]` | Exibe texto rápido na cintura com configurações automáticas |
| `/memenu` | Abre o menu NUI completo para configuração |

### Comando /me
Configurações automáticas aplicadas:
- **Cor:** Branca (#FFFFFF)
- **Fundo:** Escuro ativado
- **Tempo:** 7 segundos
- **Distância:** 20 metros
- **Local:** Cintura

### Menu /memenu

O menu oferece as seguintes opções:

#### Locais do Corpo
- Cabeça
- Tronco
- Cintura
- Mão Esquerda
- Mão Direita
- Pé Esquerdo
- Pé Direito

#### Configurações
- **Descrição:** Campo de texto para o status
- **Tempo de Exibição:** Slider ajustável (3-20 segundos)
- **Distância Visível:** Slider ajustável (1-25 metros)
- **Cor do Indicador:** Cores pré-definidas + seletor livre
- **Fundo Escuro:** Checkbox para ativar/desativar fundo nos textos
- **Asteriscos:** Checkbox para adicionar *texto* automaticamente

### Configuração

Edite o arquivo `config.lua` para personalizar:

```lua
-- Idioma: 'PT' (Português) ou 'EN' (English)
Config.Language = 'PT'

-- Limites de tempo (segundos)
Config.MaxTime = 20
Config.MinTime = 3
Config.DefaultTime = 7

-- Limites de distância (metros)
Config.MaxDistance = 25
Config.MinDistance = 1
Config.DefaultDistance = 10

-- Opções padrão
Config.DefaultTextBackground = true  -- Fundo escuro
Config.DefaultAsterisks = true       -- Asteriscos (*texto*)

-- Configurações do comando /me
Config.EnableMeCommand = true        -- true = Habilita /me | false = Apenas /memenu
Config.MeCommandName = 'me'          -- Mude para evitar conflitos com a framework
```

### Instalação

1. Coloque a pasta `ylx-memenu` em sua pasta de resources
2. Adicione `ensure ylx-memenu` ao seu server.cfg
3. Configure o `config.lua` conforme necessário
4. **⚠️ Sobre o comando /me:**
   - Se sua framework (RSG, VORP, etc.) já possui um comando `/me`, você tem 3 opções:
     - **Opção A:** Desativar o comando `/me` da framework
     - **Opção B:** Alterar `Config.MeCommandName` para outro nome (ex: `'mee'`, `'eme'`, `'status'`)
     - **Opção C:** Definir `Config.EnableMeCommand = false` para usar apenas o `/memenu`
5. Reinicie o servidor

---

## 📁 File Structure / Estrutura de Arquivos

```
ylx-memenu/
├── fxmanifest.lua
├── config.lua
├── client.lua
├── server.lua
├── README.md
└── UI/
    ├── index.html
    ├── style.css
    └── script.js
```

## 📝 Version / Versão

**v1.1.0**

## 👤 Author / Autor

**yLx**
