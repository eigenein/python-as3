package game.mechanics.dungeon.popup.floor
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mechanics.dungeon.mediator.DungeonFloorValueObject;
   import game.mechanics.dungeon.model.state.DungeonFloorBattleState;
   import game.mechanics.dungeon.model.state.DungeonFloorElementalGroup;
   import game.view.gui.components.ClipButton;
   
   public class DungeonBattleButtonDisplayBase extends GuiClipNestedContainer
   {
       
      
      public var mouse_disabled_sprite:Vector.<ClipSprite>;
      
      public function DungeonBattleButtonDisplayBase()
      {
         mouse_disabled_sprite = new Vector.<ClipSprite>();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc3_:int = 0;
         super.setNode(param1);
         var _loc2_:int = mouse_disabled_sprite.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            mouse_disabled_sprite[_loc3_].graphics.touchable = false;
            _loc3_++;
         }
      }
      
      public function getBattleButton() : ClipButton
      {
         return null;
      }
      
      public function createBattleButton(param1:DungeonFloorValueObject) : void
      {
      }
      
      public function setState(param1:DungeonFloorBattleState) : void
      {
         getBattleButton().graphics.visible = param1 == DungeonFloorBattleState.BATTLE_CAN_START;
      }
      
      public function setElements(param1:DungeonFloorElementalGroup) : void
      {
      }
   }
}
