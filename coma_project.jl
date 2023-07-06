
mutable struct Nim                          # synonym fuer Node im nim-Spielbaum
    active::Symbol                          #aktiver spieler
    board::Int                              #anzahl der steine
    moves::Vector{Dict{Int,Real}}           #gleich wie unten
    children::Dict{Int, Nim}                #direkte kinderknoten
end

mutable struct GlobalState
    players::Vector{Symbol}                 #spieler insgesamt
    moves::Vecotr{Dcit{Int, Real}}          # 1->Inf, 2->Inf man darf die zuege 1 oder 2 wegnehmen beliebig oft ausfuehren
    winCondition::Function
    root::Nim
    gameStates::Dict{Nim, Real}             #wert des Nim-Knotens
    GlobalState(players,moves,winCondition,board) = new(players,moves,winCondition,board, nothing)
end


function minMax(gState::GlobalState, state::Nim)::Real
    p::Real
    if state.board == 0                          
        if state.active == P1
            return -1
        else
            return 1
        end
    else
        if state.active == P1                                                #P1 Maximum
            for j=0:length(colect(keys(state.moves)))                         
                newChild=Nim(P2, (state.board-state.moves[j][1], state.moves, nothing)) #erstelle alle kinder 
                push!(state.children, (newChild => MinMax(newChild)))                   # und berechne deren Wert
            return max(collect(values(state.children)))
        end
        else
            for j=0:length(colect(keys(state.moves)))                         
                newChild=Nim(P2, (state.board-state.moves[j][1], state.moves, nothing))
                push!(state.children, (newChild => MinMax(newChild))) 
            return min(collect(values(state.children)))

end


function alphaBeta(gState:GlobalState, state::Nim)::Real


end



#=  ohne children falls anzahl steine > 0 dann erstelle neue Node mit 
active = anderer spieler; anzahl - moves

rufe MinMax auf alle kinder auf 
bei P1: return Maximum
bei P2: return Minimum


erst vollen graphen erstellen und dann durchmustern ist wohl einfacher
=#