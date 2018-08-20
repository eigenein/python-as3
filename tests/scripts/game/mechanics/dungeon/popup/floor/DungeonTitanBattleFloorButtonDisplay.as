package game.mechanics.dungeon.popup.floor
{
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipContainer;
   import game.assets.storage.AssetStorage;
   import game.mechanics.dungeon.mediator.DungeonFloorValueObject;
   import game.mechanics.dungeon.model.state.DungeonFloorBattleState;
   import game.mechanics.dungeon.model.state.DungeonFloorElementalGroup;
   import game.view.gui.components.ClipButton;
   
   public class DungeonTitanBattleFloorButtonDisplay extends DungeonBattleButtonDisplayBase
   {
       
      
      public var button_battle:TitanDoorButton;
      
      public var button_battle_marker:GuiClipContainer;
      
      public var rainbow_floor:GuiAnimation;
      
      public function DungeonTitanBattleFloorButtonDisplay()
      {
         button_battle_marker = new GuiClipContainer();
         super();
      }
      
      override public function getBattleButton() : ClipButton
      {
         return button_battle;
      }
      
      override public function setState(param1:DungeonFloorBattleState) : void
      {
         super.setState(param1);
         rainbow_floor.graphics.visible = param1 == DungeonFloorBattleState.BATTLE_CAN_START;
      }
      
      override public function createBattleButton(param1:DungeonFloorValueObject) : void
      {
         if(button_battle)
         {
            button_battle.graphics.parent.removeChild(button_battle.graphics);
            button_battle = null;
         }
         if(param1.elements.differentElements)
         {
            button_battle = AssetStorage.rsx.dungeon_floors.create(TitanDoorButton,"button_battle_door_" + param1.elements.DEFAULT.element1.ident);
         }
         else
         {
            button_battle = AssetStorage.rsx.dungeon_floors.create(TitanDoorButton,"button_battle_door_" + param1.elements.element1.ident);
         }
         button_battle_marker.container.addChild(button_battle.graphics);
      }
      
      override public function setElements(param1:DungeonFloorElementalGroup) : void
      {
         button_battle.setElements(param1);
      }
   }
}
