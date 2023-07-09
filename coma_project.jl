
mutable struct Nim                          # synonym fuer Node im nim-Spielbaum
    active::Symbol                          #aktiver spieler
    board::Int                              #anzahl der steine
    moves::Vector{Dict{Int,Real}}           #gleich wie unten
    children::Dict{Int, Nim}                #direkte kinderknoten
end

mutable struct GlobalState
    players::Vector{Symbol}                 #spieler insgesamt
    moves::Vector{Dict{Int, Real}}          # 1->Inf, 2->Inf man darf die zuege 1 oder 2 wegnehmen beliebig oft ausfuehren
    winCondition::Function
    root::Nim
    gameStates::Dict{Nim, Real}             #wert des Nim-Knotens
    GlobalState(players,moves,winCondition,board) = new(players,moves,winCondition,board, nothing)
end


function minMax(gState::GlobalState, state::Nim)::Real
    p::Real
    if state.board == 0                          
        if state.active == :P1
            return -1
        else
            return 1
        end
    else
        if state.active == :P1                                                                  #P1 Maximum
            max_value = -Inf                                                                    # maximum initialisieren
            for j in keys(state.moves)   
                newBoard = state.board - j                
                newChild = Nim(:P2, newBoard, state.moves, Dict{Int, Nim})                      #erstelle neues Kind
                push!(state.children, (newChild.board => newChild))                           # und berechne deren Wert
                max_value = max(max_value, minMax(gstate, newChild))
            return max_value
        end
        else
            min_value = Inf                                                                    # minimum initialisieren
            for j in keys(state.moves)   
                newBoard = state.board - j                
                newChild = Nim(:P1, newBoard, state.moves, Dict{Int, Nim})                      #erstelle neues Kind
                push!(state.children, (newChild.board => newChild))                           # und berechne deren Wert
                min_value = min(min_value, minMax(gstate, newChild))
            return min_value

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

G = GlobalState([:P1, :P2], [{1 => Inf, 2 => Inf}], nothing, Nim(:P1, 5, [], Dict{Int, Nim}()))

println(minMax(G, G.root))
