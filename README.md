# More Chess

Chess with randomly generated variant pieces.

Using a Clean Architecture system where updates to the board are down from the interactor to a state that is read from the view 

```
      ┌────────────┐                   
┌─────► Board View │                   
│     └────┬───────┘                   
│          │                           
│          │ Drag Offset               
│          │                           
│          │ ┌────────────────────────┐
│          └─► Positioning Interactor │
│            └───────────┬────────────┘
│                        │             
│               ┌────────▼──────────┐  
│               │ Positioning State │  
│               └────────┬──────────┘  
│                        │             
└────────────────────────┘                         
```
