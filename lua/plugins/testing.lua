return {
    'xeluxee/competitest.nvim', lazy = true, event = "VeryLazy",
    opts = {
        compile_command = { 'g++', '-std=c++17', '-O2', '-o', 'output', 'main.cpp' },
    },
    keys = {
        { '<F5>', ':w <CR> :!g++ -std=c++17 -O2 -o %< % <CR> :!./%< <CR>', desc = "Compile Current Buffer" },
    },
}
