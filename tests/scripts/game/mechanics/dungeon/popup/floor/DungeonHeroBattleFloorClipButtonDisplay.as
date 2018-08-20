package game.mechanics.dungeon.popup.floor
{
   import game.mechanics.dungeon.model.state.DungeonFloorBattleState;
   import game.view.gui.components.ClipButton;
   
   public class DungeonHeroBattleFloorClipButtonDisplay extends DungeonBattleButtonDisplayBase
   {
       
      
      public var button_battle:HeroDoorButton;
      
      public function DungeonHeroBattleFloorClipButtonDisplay()
      {
         button_battle = new HeroDoorButton();
         super();
      }
      
      override public function getBattleButton() : ClipButton
      {
         return button_battle;
      }
      
      override public function setState(param1:DungeonFloorBattleState) : void
      {
         super.setState(param1);
      }
   }
}
