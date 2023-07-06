
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
    if state.board < 5                          #ab 5 steinen kann man sich selbst einen Win garantieren
        if state.active == P1
            return 1
        else
            return -1
        end
    else
        if state.active == P1
            state.children = Nim(P2, state.board-1, state.moves, nothing)
            state.children = Nim(P2, state.board-2, state.moves, nothing)
            for i=0:keys(state.children)                                    #das habe ich  vllt komplett falsch verstanden
                p=p+(MinMax(state.children[i][1]))                          #bilde die summe der werte der kinderknoten

        end
    

end


function alphaBeta(gState:GlobalState, state::Nim)::Real


end



#=  ohne children falls anzahl steine > 5 dann erstelle neue Node mit 
active = anderer spieler; anzahl -1
active = anderer spieler; anzhal -2

=#