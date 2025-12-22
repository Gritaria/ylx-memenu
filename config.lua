Config = {}

-- ============================================
-- CONFIGURAÇÃO DE IDIOMA
-- Altere para: 'PT' (Português) ou 'EN' (English)
-- ============================================
Config.Language = 'EN'

-- ============================================
-- LIMITES DE TEMPO E DISTÂNCIA
-- ============================================
Config.MaxTime = 20      -- Tempo máximo de exibição (segundos)
Config.MinTime = 3       -- Tempo mínimo de exibição (segundos)
Config.DefaultTime = 7   -- Tempo padrão (segundos)

Config.MaxDistance = 25  -- Distância máxima (metros)
Config.MinDistance = 1   -- Distância mínima (metros)
Config.DefaultDistance = 10 -- Distância padrão (metros)

-- ============================================
-- FUNDO ESCURO NOS TEXTOS E ASTERISCOS
-- ============================================
Config.DefaultTextBackground = true  -- true = Fundo escuro ativado por padrão | false = Desativado
Config.DefaultAsterisks = true       -- true = Asteriscos (*texto*) habilitados por padrão | false = Desativado

-- ============================================
-- COMANDO /me
-- ============================================
-- IMPORTANTE: Se sua framework já possui um comando /me, você deve:
-- 1. Desativar o /me da framework, OU
-- 2. Mudar o nome do comando abaixo para evitar conflitos (ex: 'mee', 'eme', 'status')
-- 3. Ou definir EnableMeCommand = false para usar apenas o /memenu
-- ============================================
Config.EnableMeCommand = true        -- true = Habilita o comando /me | false = Apenas /memenu disponível
Config.MeCommandName = 'me'          -- Nome do comando (mude para evitar conflitos com a framework)

-- ============================================
-- TRADUÇÕES
-- ============================================
Config.Translations = {
    ['PT'] = {
        -- Menu Header
        menu_title = 'Menu',
        close = 'Fechar',
        clear = 'Limpar',
        
        -- Body Parts
        cabeca = 'Cabeça',
        tronco = 'Tronco',
        mao_esq = 'Mão Esquerda',
        mao_dir = 'Mão Direita',
        cintura = 'Cintura',
        pe_esq = 'Pé Esquerdo',
        pe_dir = 'Pé Direito',
        
        -- Form Labels
        body_location = 'Local do Corpo',
        description = 'Descrição',
        description_placeholder = 'Exemplo: sangrando',
        display_time = 'Tempo de Exibição',
        visible_distance = 'Distância Visível',
        indicator_color = 'Cor do Indicador',
        text_background = 'Fundo Escuro nos Textos',
        asterisks_option = 'Adicionar Asteriscos (*texto*)',
        confirm_button = 'Confirmar Status',
        
        -- Status List
        no_status = 'Nenhum status ativo.',
        saved = 'SALVO'
    },
    
    ['EN'] = {
        -- Menu Header
        menu_title = 'Menu',
        close = 'Close',
        clear = 'Clear',
        
        -- Body Parts
        cabeca = 'Head',
        tronco = 'Torso',
        mao_esq = 'Left Hand',
        mao_dir = 'Right Hand',
        cintura = 'Waist',
        pe_esq = 'Left Foot',
        pe_dir = 'Right Foot',
        
        -- Form Labels
        body_location = 'Body Location',
        description = 'Description',
        description_placeholder = 'Example: bleeding',
        display_time = 'Display Time',
        visible_distance = 'Visible Distance',
        indicator_color = 'Indicator Color',
        text_background = 'Dark Text Background',
        asterisks_option = 'Add Asterisks (*text*)',
        confirm_button = 'Confirm Status',
        
        -- Status List
        no_status = 'No active status.',
        saved = 'SAVED'
    }
}
