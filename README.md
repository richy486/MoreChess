# More Chess

Chess with randomly generated variant pieces.

![Screenshot of a game in progress where the Horse and Ninja pieces have moved](Docs/Resources/gameImage.png "Game Image")

Using a Clean Architecture system where updates to the board are down from the interactor to a state that is read from the view 

## Information flow

```
    ┌───────────┐                                                   
┌───► Game View │                                                   
│   └───────────┘──┐                                                
│     │ Board View │                                                
│     └────┬───────┘                                                
│          │                                                        
│          │ Drag Offset                                            
│          │ ┌────────────────────────┐  Move    ┌─────────────────┐
│          │ │                        ├──────────►                 │
│          └─►                        │          │                 │
│            │ Positioning Interactor │          │ Game Repository │
│            │                        │  Board   │                 │
│            │                        ◄──────────┤                 │
│            └────┬─────────────────┬─┘          └─────────────────┘
│                 │                 │                               
│                 │ Move positions  │                               
│                 │                 │                               
│          ┌──────▼────────────┐    │                               
│◄─────────┤ Positioning State │    │ Board update                  
│          └───────────────────┘    │                               
│                                   │                               
│                                   │                               
│               ┌───────────────────▼─────┐                         
│◄──────────────┤       Game State        │                         
                └─────────────────────────┘                                                                                                                          
```

## Ownership

```
MoreChessApp             
  ContentView            
    AppState             
      LobbyState         
      GameState          
      PositioningState   
      LayoutState        
    LobbyInteractor      
    PositioningInteractor
```
