let statusData = {};
let currentColor = "#ffffff";
let Config = null;
let Lang = null;
let textBackgroundEnabled = true; // Estado do fundo escuro nos textos
let asterisksEnabled = true; // Estado dos asteriscos
let firstOpen = true; // Indica se é a primeira abertura do menu na sessão

// Elementos Globais
const partSelect = document.getElementById('part-select');
const textInput = document.getElementById('text-input');
const timeSlider = document.getElementById('time-slider');
const distSlider = document.getElementById('dist-slider');
const hexInput = document.getElementById('hex-input');
const freeColorInput = document.getElementById('free-color-input');
const activeList = document.getElementById('active-list');
const appContainer = document.getElementById('app-container');

let DEFAULT_TIME = 7;
let DEFAULT_DIST = 10;
const DEFAULT_PART = "cabeca";

const partsName = {
    'cabeca': 'Cabeça',
    'tronco': 'Tronco',
    'mao_esq': 'Mão Esq.',
    'mao_dir': 'Mão Dir.',
    'cintura': 'Cintura',
    'pe_esq': 'Pé Esq.',
    'pe_dir': 'Pé Dir.'
};

// Listener para receber comandos do LUA
window.addEventListener('message', function (event) {
    if (event.data.action === 'open') {

        // Recebe configurações e traduções do Lua
        if (event.data.config) {
            Config = event.data.config;
            DEFAULT_TIME = Config.defaultTime;
            DEFAULT_DIST = Config.defaultDistance;

            // Atualiza limites dos sliders
            timeSlider.min = Config.minTime;
            timeSlider.max = Config.maxTime;
            timeSlider.value = Config.defaultTime;

            distSlider.min = Config.minDistance;
            distSlider.max = Config.maxDistance;
            distSlider.value = Config.defaultDistance;

            // Atualiza displays
            updateDisplay('time-display', Config.defaultTime, 's');
            updateDisplay('dist-display', Config.defaultDistance, 'm');

            // Atualiza labels dos sliders
            document.querySelectorAll('.flex.justify-between.text-\\[8px\\]')[0].innerHTML =
                `<span>${Config.minTime}s</span><span>${Config.maxTime}s</span>`;
            document.querySelectorAll('.flex.justify-between.text-\\[8px\\]')[1].innerHTML =
                `<span>${Config.minDistance}m</span><span>${Config.maxDistance}m</span>`;

            // Configura o estado inicial APENAS na primeira abertura
            if (firstOpen) {
                if (Config.defaultTextBackground !== undefined) {
                    textBackgroundEnabled = Config.defaultTextBackground;
                }
                if (Config.defaultAsterisks !== undefined) {
                    asterisksEnabled = Config.defaultAsterisks;
                }
                firstOpen = false;
            }
        }

        // Sincroniza checkboxes com os valores atuais (que persistem na sessão)
        document.getElementById('text-background-checkbox').checked = textBackgroundEnabled;
        document.getElementById('asterisks-checkbox').checked = asterisksEnabled;

        if (event.data.translations) {
            Lang = event.data.translations;
            applyTranslations();
        }

        appContainer.classList.add('show');
        loadPartData();
        textInput.value = ''; // Limpa o texto ao abrir o menu (depois de loadPartData para garantir)
    } else if (event.data.action === 'close') {
        appContainer.classList.remove('show');
    }
});

// Aplica traduções na interface
function applyTranslations() {
    if (!Lang) return;

    // Header
    document.querySelector('.bg-neutral-900 h1').textContent = Lang.menu_title;
    document.querySelector('button[onclick="closeUI()"]').textContent = Lang.close;
    document.querySelector('button[onclick="resetAll()"]').textContent = Lang.clear;

    // Labels
    document.querySelectorAll('label')[0].textContent = Lang.body_location;
    document.querySelectorAll('label')[1].textContent = Lang.description;
    document.querySelectorAll('label')[2].textContent = Lang.display_time;
    document.querySelectorAll('label')[3].textContent = Lang.visible_distance;
    document.querySelectorAll('label')[4].textContent = Lang.text_background;
    document.querySelectorAll('label')[5].textContent = Lang.asterisks_option;
    document.querySelectorAll('label')[6].textContent = Lang.indicator_color;

    // Placeholder
    textInput.placeholder = Lang.description_placeholder;

    // Botão
    document.querySelector('button[onclick="saveStatus()"]').textContent = Lang.confirm_button;

    // Opções do select
    partSelect.innerHTML = `
        <option value="cabeca" selected>${Lang.cabeca}</option>
        <option value="tronco">${Lang.tronco}</option>
        <option value="mao_esq">${Lang.mao_esq}</option>
        <option value="mao_dir">${Lang.mao_dir}</option>
        <option value="cintura">${Lang.cintura}</option>
        <option value="pe_esq">${Lang.pe_esq}</option>
        <option value="pe_dir">${Lang.pe_dir}</option>
    `;

    // Atualiza partsName para usar traduções
    Object.keys(partsName).forEach(key => {
        if (Lang[key]) {
            partsName[key] = Lang[key];
        }
    });
}

// Fechar com ESC
document.onkeydown = function (data) {
    if (data.which == 27) {
        closeUI();
    }
};

function closeUI() {
    if (window.invokeNative) {
        appContainer.classList.remove('show');
        const resourceName = window.GetParentResourceName ? GetParentResourceName() : 'ylx-memenu';
        fetch(`https://${resourceName}/close`, { method: 'POST' });
    } else {
        appContainer.classList.remove('show');
    }
}

function postData(action, data) {
    if (window.invokeNative) {
        const resourceName = window.GetParentResourceName ? GetParentResourceName() : 'ylx-memenu';
        fetch(`https://${resourceName}/${action}`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json; charset=UTF-8' },
            body: JSON.stringify(data)
        });
    } else {
    }
}

function updateDisplay(id, val, unit) { document.getElementById(id).innerText = val + unit; }

function setColor(c) {
    currentColor = c; hexInput.value = c.replace('#', ''); freeColorInput.value = c;
}
function updateFromHex(v) {
    if (v.length === 6) { currentColor = '#' + v; freeColorInput.value = currentColor; }
}
function updateFromPicker(v) {
    currentColor = v; hexInput.value = v.replace('#', '');
}

function loadPartData() {
    const part = partSelect.value;
    if (!part) return;

    const data = statusData[part];

    // Se já existe status salvo para esta parte, carrega os dados
    if (data) {
        textInput.value = data.text;
        timeSlider.value = data.time;
        distSlider.value = data.dist;
        setColor(data.color);
        updateDisplay('time-display', data.time, 's');
        updateDisplay('dist-display', data.dist, 'm');
    }
    // Se não existe status salvo, mantém o texto atual e reseta apenas os sliders
    // (permite digitar antes de escolher a parte do corpo)
}

function saveStatus() {
    const part = partSelect.value;
    const text = textInput.value.trim();
    if (!part) return;

    if (!text) {
        delete statusData[part];
    } else {
        // Verifica se deve adicionar asteriscos
        const addAsterisks = document.getElementById('asterisks-checkbox').checked;
        const finalText = addAsterisks ? `*${text}*` : text;

        // Verifica se deve adicionar fundo escuro
        const hasBackground = document.getElementById('text-background-checkbox').checked;

        statusData[part] = {
            text: finalText,
            time: parseInt(timeSlider.value),
            dist: parseInt(distSlider.value),
            color: currentColor,
            textBackground: hasBackground
        };
    }
    renderList();

    postData('updateStatus', {
        part: part,
        data: statusData[part]
    });

    const btn = document.querySelector('button[onclick="saveStatus()"]');
    const originalText = btn.innerText;
    btn.innerText = Lang ? Lang.saved : "SALVO";
    btn.classList.add('bg-green-500', 'text-white');
    setTimeout(() => {
        btn.innerText = originalText;
        btn.classList.remove('bg-green-500', 'text-white');
        // Fecha o menu automaticamente após salvar
        closeUI();
    }, 500);
}

// Nova função para executar/reativar um status salvo ao clicar nele
function executeStatus(part) {
    const data = statusData[part];
    if (!data) return;

    // Reenvia o status para o servidor
    postData('updateStatus', {
        part: part,
        data: data
    });

    // Fecha o menu após executar
    setTimeout(() => {
        closeUI();
    }, 300);
}

function removeStatus(part) {
    delete statusData[part];
    renderList();
    if (partSelect.value === part) textInput.value = '';
    postData('updateStatus', { part: part, data: null });
}

function resetAll() {
    statusData = {};
    renderList();
    loadPartData();
    postData('clearAll', {});
}

// Função para alternar o fundo escuro nos textos 3D
function toggleTextBackground(enabled) {
    textBackgroundEnabled = enabled;

    // Envia para o client.lua para atualizar os textos 3D no mundo
    postData('setTextBackground', { enabled: enabled });
}

// Função para alternar os asteriscos no texto
function toggleAsterisks(enabled) {
    asterisksEnabled = enabled;
}

function renderList() {
    activeList.innerHTML = '';
    const keys = Object.keys(statusData);
    if (keys.length === 0) {
        const noStatusText = Lang ? Lang.no_status : 'Nenhum status ativo.';
        activeList.innerHTML = `<p class="text-center text-[10px] text-neutral-600 py-2">${noStatusText}</p>`;
        return;
    }
    keys.forEach(key => {
        const data = statusData[key];
        const item = document.createElement('div');
        item.className = "flex justify-between items-center bg-black/40 p-2 rounded border-l-2 border-neutral-700 hover:bg-black/60 transition mb-1 cursor-pointer";
        item.style.borderLeftColor = data.color;
        item.innerHTML = `
            <div class="overflow-hidden flex-1" onclick="executeStatus('${key}')">
                <div class="flex items-baseline gap-2">
                    <span class="text-[10px] font-bold text-neutral-400 uppercase">${partsName[key]}</span>
                    <span class="text-[9px] text-neutral-600 font-mono">${data.time}s | ${data.dist}m</span>
                </div>
                <div class="text-xs text-neutral-200 truncate">${data.text}</div>
            </div>
            <button onclick="event.stopPropagation(); removeStatus('${key}')" class="text-neutral-600 hover:text-red-500 ml-2 px-1">&times;</button>
        `;
        activeList.appendChild(item);
    });
}

// AUTO-DETECTAR NAVEGADOR PARA TESTES (Permite ver no Canvas ou Navegador)
window.onload = function () {
    if (!window.invokeNative) {
        appContainer.classList.add('show');
        document.body.style.backgroundImage = "url('https://images.unsplash.com/photo-1542256844-3112dc2675da?q=80&w=2070&auto=format&fit=crop')";
        document.body.style.backgroundSize = "cover";
    }
    loadPartData();
};
