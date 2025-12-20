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
-- FUNDO ESCURO NOS TEXTOS
-- ============================================
Config.DefaultTextBackground = true  -- true = Fundo escuro ativado por padrão | false = Desativado

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
        pe_esq = 'Pé Esquerdo',
        pe_dir = 'Pé Direito',
        
        -- Form Labels
        body_location = 'Local do Corpo',
        description = 'Descrição',
        description_placeholder = 'Ex: Fratura exposta...',
        display_time = 'Tempo de Exibição',
        visible_distance = 'Distância Visível',
        indicator_color = 'Cor do Indicador',
        text_background = 'Fundo Escuro nos Textos',
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
        pe_esq = 'Left Foot',
        pe_dir = 'Right Foot',
        
        -- Form Labels
        body_location = 'Body Location',
        description = 'Description',
        description_placeholder = 'Ex: Compound fracture...',
        display_time = 'Display Time',
        visible_distance = 'Visible Distance',
        indicator_color = 'Indicator Color',
        text_background = 'Dark Text Background',
        confirm_button = 'Confirm Status',
        
        -- Status List
        no_status = 'No active status.',
        saved = 'SAVED'
    }
}
